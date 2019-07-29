import XMonad

import XMonad.Layout.Tabbed
--import XMonad.Layout.Circle
import XMonad.Layout.ThreeColumns
--import XMonad.Layout.Spiral
--import XMonad.Layout.Gaps

import XMonad.Layout.Gaps
import XMonad.Layout.Circle
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.Fullscreen
import XMonad.Layout.ResizableTile
import XMonad.Layout.SimplestFloat
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import XMonad.Hooks.ManageDocks (manageDocks, avoidStruts)

import Control.Monad
import XMonad.Util.EZConfig(additionalKeys)

myBrowser            = "vivaldi-stable"
myLauncher           = "dmenu_run" 
myTerminal           = "kitty" 
myModMask            = mod4Mask
myBorderWidth        = 4
myNormalBorderColor  = "#222222"
myFocusedBorderColor = "#aa0000"

-- keybindings
--myKeys =
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
   [ ((modMask, xK_Return), spawn myTerminal)
   , ((modMask, xK_t)     , spawn myTerminal) 
   , ((modMask, xK_b)     , spawn myBrowser )
   , ((modMask, xK_d)     , spawn myLauncher)
   , ((modMask, xK_q)     , kill            )
   
   -- modifying the window order
   , ((modMask,               xK_Tab   ), windows W.swapMaster) -- %! Swap the focused window and the master window
   , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  ) -- %! Swap the focused window with the next window
   , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    ) -- %! Swap the focused window with the previous window
   , ((modMask .|. shiftMask, xK_Down  ), windows W.swapDown  ) -- %! Swap the focused window with the next window
   , ((modMask .|. shiftMask, xK_Up    ), windows W.swapUp    ) -- %! Swap the focused window with the previous window
   , ((modMask .|. shiftMask, xK_Left  ), windows W.swapMaster) -- %! Swap the focused window with the previous window
   , ((modMask .|. shiftMask, xK_Right ), windows W.swapDown  ) -- %! Swap the focused window with the previous window

   -- move focus up or down the window stack
   , ((modMask,               xK_j     ), windows W.focusDown) -- %! Move focus to the next window
   , ((modMask,               xK_k     ), windows W.focusUp  ) -- %! Move focus to the previous window
   , ((modMask,               xK_Down  ), windows W.focusDown) -- %! Move focus to the next window
   , ((modMask,               xK_Up    ), windows W.focusUp  ) -- %! Move focus to the previous window

   , ((modMask,               xK_Left  ), windows W.focusMaster  ) -- %! Move focus to the next window
   , ((modMask,               xK_Right ), windows W.focusDown    ) -- %! Move focus to the next window
   , ((modMask,               xK_m     ), windows W.focusMaster  ) -- %! Move focus to the master window

   -- modifying the window order
   , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  ) -- %! Swap the focused window with the next window
   , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    ) -- %! Swap the focused window with the previous window

   -- RECOMPILE AND RESTART XMONAD
   , ((modMask .|. shiftMask, xK_r     ), spawn "xmonad --restart")
  ]

-- AUTOSTART
myStartupHook :: X()
myStartupHook = do
   spawn "$HOME/.config/autostart.sh"

-- main = xmonad $ def
--          { modMask = mod4Mask
--          , terminal = myTerminal
--          , startupHook = myStartupHook
--          } `additionalKeys` myKeys
 
-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will 
-- use the defaults defined in xmonad/XMonad/Config.hs
-- 
-- No need to modify this.
--
defaults = defaultConfig {
      -- simple stuff
         terminal           = myTerminal
        ,borderWidth        = myBorderWidth
        ,modMask            = myModMask
--        ,numlockMask        = myNumlockMask
--        ,workspaces         = myWorkspaces
        ,normalBorderColor  = myNormalBorderColor
        ,focusedBorderColor = myFocusedBorderColor
 
      -- key bindings
        ,keys               = myKeys
--        ,mouseBindings      = myMouseBindings
 
      -- hooks, layouts
        ,startupHook        = myStartupHook
        ,layoutHook         = myLayout
--        ,manageHook         = myManageHook
--        ,logHook            = myLogHook
    }

------------------------------------------------------------------------
-- Layouts:
 
-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout =  gaps [(U, 4), (R, 4), (L, 4), (D, 32)] (avoidStruts $ smartBorders (spacing 4 $ resizable ||| Circle ||| float)) ||| full

--           tiled
--           ||| Full
--           ||| Mirror tiled
--           ||| tabbed shrinkText defaultTheme
--           ||| threeCol
--           ||| spiral (4/3)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     threeCol = ThreeCol nmaster delta ratio
 
     -- The default number of windows in the master pane
     nmaster = 1
 
     -- Default proportion of screen occupied by master pane
     ratio   = 1/2
 
     -- Percent of screen to increment by when resizing panes
     delta   = 2/100

     float       = simplestFloat
     full        = noBorders (fullscreenFull Full)
     resizable   = ResizableTall 1 (2/100) (1/2) []

-- Now run xmonad with all the defaults we set up.
 
-- Run xmonad with the settings you specify. No need to modify this.
--
main = xmonad defaults



