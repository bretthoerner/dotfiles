import XMonad
import XMonad.Actions.CopyWindow (copyToAll, killAllOtherCopies, kill1)
import XMonad.Actions.CycleWS (toggleWS)
import XMonad.Actions.DynamicWorkspaces
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks (avoidStruts)
import XMonad.Hooks.ManageHelpers (isDialog, isFullscreen, doCenterFloat, doFullFloat)
import XMonad.Hooks.SetWMName
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Prompt (defaultXPConfig)
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig (additionalKeysP)

import qualified Data.Map as M

myLayout =  smartBorders $ avoidStruts $ ResizableTall 1 (3/100) (2/3) [] ||| Full
myManageHook :: [ManageHook]
myManageHook =
    [ resource  =? "gcalctool" --> doCenterFloat
    , isFullscreen --> doFullFloat
    , isDialog --> doCenterFloat ]

toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myConfig = defaultConfig
    { manageHook = manageHook defaultConfig <+> composeAll myManageHook
    , layoutHook = myLayout
    , handleEventHook = handleEventHook defaultConfig <+> fullscreenEventHook
    , focusFollowsMouse = False
    , modMask = mod4Mask
    , startupHook = ewmhDesktopsStartup >> setWMName "LG3D"
    , terminal = "gnome-terminal"
    , borderWidth = 1 }
    `additionalKeysP`
    [ ("M-a", sendMessage MirrorShrink)
    , ("M-z", sendMessage MirrorExpand)
    , ("M-d", removeWorkspace)
    , ("M-r", renameWorkspace defaultXPConfig)
    , ("M-'", selectWorkspace defaultXPConfig)
    , ("M-S-'", withWorkspace defaultXPConfig (windows . W.shift))
    , ("M-0", toggleWS)
    , ("M-S-=", windows copyToAll)
    , ("M-=",  killAllOtherCopies)
    , ("M--",  kill1)
    , ("<XF86AudioLowerVolume>", spawn "amixer -c 0 set Master 3dB-")
    , ("<XF86AudioRaiseVolume>", spawn "amixer -c 0 set Master 3dB+")
    , ("<XF86AudioMute>", spawn "amixer -c 0 set Master toggle")]

main = xmonad =<< statusBar "xmobar" xmobarPP toggleStrutsKey myConfig

