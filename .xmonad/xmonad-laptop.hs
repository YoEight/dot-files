import qualified Data.Map as M

import qualified Data.Map as M
import           Graphics.X11.ExtraTypes.XF86
import           XMonad
import qualified XMonad.StackSet as W
import           XMonad.Hooks.DynamicLog
import           XMonad.Util.EZConfig

setNumLockMask :: KeyMask -> X ()
setNumLockMask m = modify $ \x -> x { numberlockMask = m }

main = do conf <- xmobar myConfig
          xmonad conf

-- XF86AudioLowerVolume
-- XF86AudioRaiseVolume
anotherKeys :: [((KeyMask, KeySym), X ())]
anotherKeys =
    [ ((noModMask, xF86XK_MonBrightnessUp), spawn "xbacklight +5")
    , ((noModMask, xF86XK_MonBrightnessDown), spawn "xbacklight -5")
    , ((noModMask, xF86XK_AudioLowerVolume), spawn "amixer -D pulse sset Master 5%-> /dev/null")
    , ((noModMask, xF86XK_AudioRaiseVolume), spawn "amixer -D pulse sset Master 5%+ > /dev/null")
    , ((noModMask, xF86XK_AudioMute), spawn "amixer set Master toggle > /dev/null")
    ]

myConfig
    = bepoConfig
      { workspaces  = myWorkspaces
      , modMask     = mod4Mask
      , terminal    = "gnome-terminal"
      , startupHook = setNumLockMask 0
      } `additionalKeys` anotherKeys

myWorkspaces = ["I","II","III", "IV", "V"]

bepoConfig = defaultConfig { keys = myKeys <+> bepoKeys <+> keys defaultConfig }

myKeys conf@(XConfig {modMask = modm}) = M.fromList $
    [((modm, xK_p), spawn "dmenu_run -fn 'Consolas-11'")]

bepoKeys conf@(XConfig { modMask = modm }) = M.fromList $
    [((modm, xK_semicolon), sendMessage (IncMasterN (-1)))]
    ++
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (workspaces conf) [0x22,0xab,0xbb,0x28,0x29,0x40,0x2b,0x2d,0x2f,0x2a],
          (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
