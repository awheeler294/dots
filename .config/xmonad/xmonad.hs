import XMonad
import Control.Monad
import XMonad.Util.EZConfig(additionalKeys)
import qualified XMonad.StackSet as W

myBrowser = "vivaldi-stable"
myLauncher = "dmenu_run" 
myTerminal = "kitty" 

-- keybindings
myKeys = 
   [ ((mod4Mask, xK_Return), spawn myTerminal)
   , ((mod4Mask, xK_t)     , spawn myTerminal) 
   , ((mod4Mask, xK_b)     , spawn myBrowser )
   , ((mod4Mask, xK_d)     , spawn myLauncher)
   , ((mod4Mask, xK_q)     , kill            )
   
   -- modifying the window order
   , ((mod4Mask,               xK_Tab   ), windows W.swapMaster) -- %! Swap the focused window and the master window
   , ((mod4Mask .|. shiftMask, xK_j     ), windows W.swapDown  ) -- %! Swap the focused window with the next window
   , ((mod4Mask .|. shiftMask, xK_k     ), windows W.swapUp    ) -- %! Swap the focused window with the previous window
   , ((mod4Mask .|. shiftMask, xK_Down  ), windows W.swapDown  ) -- %! Swap the focused window with the next window
   , ((mod4Mask .|. shiftMask, xK_Up    ), windows W.swapUp    ) -- %! Swap the focused window with the previous window
   , ((mod4Mask .|. shiftMask, xK_Left  ), windows W.swapMaster) -- %! Swap the focused window with the previous window
   , ((mod4Mask .|. shiftMask, xK_Right ), windows W.swapDown  ) -- %! Swap the focused window with the previous window

   -- move focus up or down the window stack
   , ((mod4Mask,               xK_j     ), windows W.focusDown) -- %! Move focus to the next window
   , ((mod4Mask,               xK_k     ), windows W.focusUp  ) -- %! Move focus to the previous window
   , ((mod4Mask,               xK_Down  ), windows W.focusDown) -- %! Move focus to the next window
   , ((mod4Mask,               xK_Up    ), windows W.focusUp  ) -- %! Move focus to the previous window

   , ((mod4Mask,               xK_Left  ), windows W.focusMaster  ) -- %! Move focus to the next window
   , ((mod4Mask,               xK_Right ), windows W.focusDown    ) -- %! Move focus to the next window
   , ((mod4Mask,               xK_m     ), windows W.focusMaster  ) -- %! Move focus to the master window

   -- modifying the window order
   , ((mod4Mask .|. shiftMask, xK_j     ), windows W.swapDown  ) -- %! Swap the focused window with the next window
   , ((mod4Mask .|. shiftMask, xK_k     ), windows W.swapUp    ) -- %! Swap the focused window with the previous window

   -- RECOMPILE AND RESTART XMONAD
   , ((mod4Mask .|. shiftMask, xK_r     ), spawn "xmonad --restart")
  ]

-- AUTOSTART
myStartupHook :: X()
myStartupHook = do
   spawn "$HOME/.config/autostart.sh"

main = xmonad $ def
         { modMask = mod4Mask
         , terminal = myTerminal
         , startupHook = myStartupHook
         } `additionalKeys` myKeys


