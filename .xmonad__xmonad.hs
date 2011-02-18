-- To replace Metacity,
-- gconftool-2 -s /desktop/gnome/session/required_components/windowmanager xmonad --type string

import XMonad
import XMonad.Actions.DynamicWorkspaces
import XMonad.Actions.CycleWS (toggleWS)
import XMonad.Config.Gnome (gnomeConfig)
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks (avoidStruts)
import XMonad.Hooks.ManageHelpers (isDialog, isFullscreen, doCenterFloat, doFullFloat)
import XMonad.Hooks.SetWMName
import XMonad.Layout.ResizableTile
import XMonad.Prompt (defaultXPConfig)
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig (additionalKeysP)

import qualified Data.Map as M

myLayout =  avoidStruts $ ResizableTall 1 (3/100) (1/2) [] ||| Full
myManageHook :: [ManageHook]
myManageHook =
    [ resource  =? "Do" --> doIgnore
    , resource  =? "gcalctool" --> doCenterFloat
    , isFullscreen --> doFullFloat
    , isDialog --> doCenterFloat ]

main = xmonad $ gnomeConfig
    { manageHook = manageHook gnomeConfig <+> composeAll myManageHook
    , layoutHook = myLayout
    , focusFollowsMouse = False
    , modMask = mod4Mask
    , startupHook = ewmhDesktopsStartup >> setWMName "LG3D"
    , borderWidth = 3 }
    `additionalKeysP`
    [ ("M-a", sendMessage MirrorShrink)
    , ("M-z", sendMessage MirrorExpand)
    , ("M-d", removeWorkspace)
    , ("M-r", renameWorkspace defaultXPConfig)
    , ("M-'", selectWorkspace defaultXPConfig)
    , ("M-S-'", withWorkspace defaultXPConfig (windows . W.shift))
    , ("M-0", toggleWS) ]
