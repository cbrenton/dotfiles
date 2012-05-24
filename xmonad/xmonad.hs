import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)

import System.IO

import qualified XMonad.StackSet as W
import qualified Data.Map as M

myTerminal = "urxvt"
myWorkspaces = ["1:main", "2:web", "3:code", "4:media", "5:file", "6", "7", "8:sound", "9:min"]
myModMask = mod4Mask    -- Win key or Super_L
myLayoutHook = avoidStruts $ layoutHook defaultConfig
myManageHook = (composeAll . concat $ [
      [resource      =? r              --> doIgnore            |  r  <- myIgnores], -- ignore desktop
      [className     =? c              --> doShift "2:web"     |  c  <- myWeb    ], -- move web to main
      [className     =? c              --> doShift "4:media"   |  c  <- myMedia  ], -- move media to main
      [className     =? c              --> doShift "5:file"    |  c  <- myFile   ], -- move file to main
      [className     =? c              --> doCenterFloat       |  c  <- myFloats ], -- float my floats
      [name          =? n              --> doCenterFloat       |  n  <- myNames  ], -- float my names
      [isFullscreen                    --> myDoFullFloat                         ]
      ])

      where

         role        = stringProperty "WM_WINDOW_ROLE"
         name        = stringProperty "WM_NAME"

         -- classnames
         myFloats    = ["Gimp","Skype"]
         myWeb       = ["Firefox","Google-chrome","Chromium"]
         myMedia     = ["Vlc","Clementine"]
         myFile      = ["Thunar"]

         -- ignores
         myIgnores   = ["desktop","desktop_window","notify-osd","trayer"]

         -- names
         myNames     = ["Google Chrome Options","Chromium Options"]

-- a trick for fullscreen but stil allow focusing of other WSs
myDoFullFloat :: ManageHook
myDoFullFloat = doF W.focusDown <+> doFullFloat

--myManageHook = composeAll [
--   className =? "Gimp"        --> doFloat,
--   className =? "Skype"       --> doFloat
--   ]
myNormalBorderColor = "#CCCCC6"
myFocusedBorderColor = "#FF0000"
myBorderWidth = 2

main = do
   xmproc <- spawnPipe "/usr/bin/xmobar /home/cbr/.xmobarrc"
   xmonad $ defaultConfig {
      terminal             = myTerminal,
      workspaces           = myWorkspaces,
      modMask              = myModMask,
      layoutHook           = myLayoutHook,
      manageHook           = manageDocks <+> myManageHook
                     <+> manageHook defaultConfig,
      logHook              = dynamicLogWithPP xmobarPP {
                                 ppOutput = hPutStrLn xmproc,
                                 ppTitle = xmobarColor "green" "" . shorten 50
                           },
      normalBorderColor    = myNormalBorderColor,
      focusedBorderColor   = myFocusedBorderColor,
      borderWidth          = myBorderWidth
      } `additionalKeys` [
      ((myModMask, xK_p), spawn "dmenu_run"),
      ((myModMask .|. shiftMask, xK_c), kill),
      ((myModMask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock"),
      ((myModMask, xK_o), spawn "chromium"),
      ((myModMask, xK_i), spawn "thunar"),
      ((0, xK_Print), spawn "scrot"),
      ((0, 0x1008ff12), spawn "amixer -q sset Headphone toggle"), -- XF86AudioMute
      ((0, 0x1008ff11), spawn "amixer -q sset Headphone 5%-"), -- XF86AudioLowerVolume
      ((0, 0x1008ff13), spawn "amixer -q sset Headphone 5%+"), -- XF86AudioRaiseVolume
      ((myModMask, xK_b), sendMessage ToggleStruts),
      ((myModMask, xK_Tab), windows W.focusDown)
      ]
      -- solarized color pallette
         -- solbase03  = "#002b36"
         -- solbase02  = "#073642"
         -- solbase01  = "#586e75"
         -- solbase00  = "#657b83"
         -- solbase0   = "#839496"
         -- solbase1   = "#93a1a1"
         -- solbase2   = "#eee8d5"
         -- solbase3   = "#fdf6e3"
         -- solyellow  = "#b58900"
         -- solorange  = "#cb4b16"
         -- solred     = "#dc322f"
         -- solmagenta = "#d33682"
         -- solviolet  = "#6c71c4"
         -- solblue    = "#268bd2"
         -- solcyan    = "#2aa198"
         -- solgreen   = "#859900"
