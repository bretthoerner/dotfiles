import Data.List (isPrefixOf)
import XMonad
import XMonad.Actions.CopyWindow (copyToAll, killAllOtherCopies, kill1)
import XMonad.Actions.CycleWS (toggleWS)
import XMonad.Actions.DynamicWorkspaces
import XMonad.Actions.GridSelect
import XMonad.Config.Gnome (gnomeConfig)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks (avoidStruts)
import XMonad.Hooks.ManageHelpers (isDialog, isFullscreen, doCenterFloat, doFullFloat)
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook (withUrgencyHook, FocusHook(..))
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Prompt (defaultXPConfig)
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Run
import qualified Data.Map as M
import qualified XMonad.StackSet as W

{- IntelliJ popup fix from http://youtrack.jetbrains.com/issue/IDEA-74679#comment=27-417315 -}
{- and http://youtrack.jetbrains.com/issue/IDEA-101072#comment=27-456320 -}
(~=?) :: Eq a => Query [a] -> [a] -> Query Bool
q ~=? x = fmap (isPrefixOf x) q

-- myLayout =  smartBorders $ avoidStruts $ ResizableTall 1 (3/100) (2/3) [] ||| Full
myManageHook :: [ManageHook]
myManageHook =
    [ resource  =? "gcalctool" --> doCenterFloat
    , resource  =? "gnome-calculator" --> doCenterFloat
    , resource  =? "gnome-control-center" --> doCenterFloat
    , isFullscreen --> doFullFloat
    , isDialog --> doCenterFloat
    , (className ~=? "jetbrains-") <&&> (title ~=? "win") --> doIgnore
    , appName =? "sun-awt-X11-XWindowPeer" <&&> className =? "jetbrains-clion" --> doIgnore
    , appName =? "sun-awt-X11-XWindowPeer" <&&> className =? "jetbrains-idea" --> doIgnore ]

toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myConfig = withUrgencyHook FocusHook $ ewmh defaultConfig
    { manageHook = manageHook defaultConfig <+> composeAll myManageHook
    , layoutHook = smartBorders $ avoidStruts (layoutHook gnomeConfig)
    , handleEventHook = handleEventHook defaultConfig <+> fullscreenEventHook
    , focusFollowsMouse = False
    , modMask = mod4Mask
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
    , ("M-=", killAllOtherCopies)
    , ("M--", kill1)
    , ("M-S-l", spawn "xscreensaver-command -l")
    , ("M-S-s", spawn "/home/brett/bin/screenshot")
    , ("<XF86MonBrightnessDown>", spawn "xbacklight -dec 10")
    , ("<XF86MonBrightnessUp>", spawn "xbacklight -inc 10")
    , ("S-<XF86MonBrightnessDown>", spawn "xbacklight -dec 5")
    , ("S-<XF86MonBrightnessUp>", spawn "xbacklight -inc 5")
    , ("<XF86AudioLowerVolume>", spawn "ponymix decrease 2")
    , ("<XF86AudioRaiseVolume>", spawn "ponymix increase 2")
    , ("<XF86AudioMute>", spawn "ponymix toggle")
    , ("M-g", goToSelected defaultGSConfig)]

main = do {
  conf <- statusBar "xmobar" xmobarPP toggleStrutsKey myConfig;
  xmonad conf { startupHook = startupHook myConfig >> setWMName "LG3D" } }
