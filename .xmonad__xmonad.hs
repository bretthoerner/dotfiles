-- To replace Metacity,
-- gconftool-2 -s /desktop/gnome/session/required_components/windowmanager xmonad --type string

import XMonad
import XMonad.Config.Gnome (gnomeConfig)
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks (avoidStruts)
import XMonad.Hooks.ManageHelpers (isDialog, isFullscreen, doCenterFloat, doFullFloat)
import XMonad.Hooks.SetWMName
import XMonad.Layout.ResizableTile

import qualified Data.Map as M

myLayout =  avoidStruts (ResizableTall 1 (3/100) (1/2) [])
myKeys conf@(XConfig {XMonad.modMask = mod4Mask}) =
       [ ((mod4Mask, xK_a), sendMessage MirrorShrink)
       , ((mod4Mask, xK_z), sendMessage MirrorExpand) ]
newKeys x  = M.union (keys gnomeConfig x) (M.fromList (myKeys x))
myManageHook :: [ManageHook]
myManageHook =
    [ resource  =? "Do" --> doIgnore
    , resource  =? "gcalctool" --> doCenterFloat
    , isFullscreen --> doFullFloat
    , isDialog --> doCenterFloat ]

main = xmonad gnomeConfig
    { manageHook = manageHook gnomeConfig <+> composeAll myManageHook
    , layoutHook = myLayout
    , keys = newKeys
    , focusFollowsMouse = False
    , modMask = mod4Mask
    , startupHook = ewmhDesktopsStartup >> setWMName "LG3D"
    , borderWidth = 3 }
