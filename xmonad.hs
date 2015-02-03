import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

import System.Posix.Env (getEnv)
import Data.Maybe (maybe)
import Data.Map (fromList)
import qualified Data.Map as Map

import XMonad
import XMonad.Layout.IndependentScreens
import XMonad.Config.Desktop
import XMonad.Config.Gnome
import XMonad.Config.Kde
import XMonad.Config.Xfce
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops

myWorkspaces = ["1: Emacs","2: Browsing","3: Terminal","4: Pdf","5","6","7","8: Music","9: Daemons"]


main = do
    nScreens <- countScreens
    xmproc <- spawnPipe "/usr/bin/xmobar /home/rickard/.xmobarrc"
    xmonad $ ewmh defaultConfig
        {
	    manageHook = composeOne
            [
                isKDETrayWindow -?> doIgnore,
                transience,
                isFullscreen -?> doFullFloat,
                resource =? "stalonetray" -?> doIgnore
            ] <+> manageDocks <+> manageHook defaultConfig
            , layoutHook = avoidStruts  $  layoutHook defaultConfig
            , logHook = dynamicLogWithPP xmobarPP
            {
                ppOutput = hPutStrLn xmproc
                , ppTitle = xmobarColor "#88ff88" "" . shorten 50
            }
            ,workspaces = myWorkspaces
            , modMask = mod4Mask     -- Rebind Mod to the Windows key
        }
        `additionalKeys`
        [
            ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
            , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
            , ((0, xK_Print), spawn "scrot")
        ]