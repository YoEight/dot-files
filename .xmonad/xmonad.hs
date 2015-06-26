import qualified Data.Map as M

import           XMonad
import qualified XMonad.StackSet as W
import           XMonad.Hooks.DynamicLog

setNumLockMask :: KeyMask -> X ()
setNumLockMask m = modify $ \x -> x { numberlockMask = m }

main = do conf <- xmobar myConfig
          xmonad conf

myConfig
    = bepoConfig
      { workspaces  = myWorkspaces
      , modMask     = mod4Mask
      , terminal    = "gnome-terminal"
      , startupHook = setNumLockMask 0
      }

myWorkspaces = ["1:main","2:web","3:communication", "4:monitoring", "5:misc"]

bepoConfig = defaultConfig { keys = bepoKeys <+> keys defaultConfig }

bepoKeys conf@(XConfig { modMask = modm }) = M.fromList $
    [((modm, xK_semicolon), sendMessage (IncMasterN (-1)))]
    ++
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (workspaces conf) [0x22,0xab,0xbb,0x28,0x29,0x40,0x2b,0x2d,0x2f,0x2a],
          (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
