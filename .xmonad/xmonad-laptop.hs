import qualified Data.Map as M

import           Control.Monad
import qualified Data.Map as M
import           Graphics.X11.ExtraTypes.XF86
import qualified Sound.ALSA.Mixer as ALSA -- Requires alsa-mixer package
import           XMonad
import qualified XMonad.StackSet as W
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.SetWMName
import           XMonad.Util.EZConfig

setNumLockMask :: KeyMask -> X ()
setNumLockMask m = modify $ \x -> x { numberlockMask = m }

main = do conf <- xmobar myConfig
          xmonad conf

-- XF86AudioLowerVolume
-- XF86AudioRaiseVolume
alsa_decrease :: X ()
alsa_decrease = io $ ALSA.withMixer "default" $ decreaseVolume (Pourcentage 5)

alsa_increase :: X ()
alsa_increase = io $ ALSA.withMixer "default" $ increaseVolume (Pourcentage 5)

alsa_toggle_mute :: X ()
alsa_toggle_mute = io $ ALSA.withMixer "default" toggleMute

anotherKeys :: [((KeyMask, KeySym), X ())]
anotherKeys =
    [ ((noModMask, xF86XK_MonBrightnessUp), spawn "xbacklight +8")
    , ((noModMask, xF86XK_MonBrightnessDown), spawn "xbacklight -8")
    -- , ((noModMask, xF86XK_AudioLowerVolume), spawn "amixer -D pulse sset Master 5%-> /dev/null")
    , ((noModMask, xF86XK_AudioLowerVolume), alsa_decrease)
    -- , ((noModMask, xF86XK_AudioRaiseVolume), spawn "amixer -D pulse sset Master 5%+ > /dev/null")
    , ((noModMask, xF86XK_AudioRaiseVolume), alsa_increase)
    -- , ((noModMask, xF86XK_AudioMute), spawn "amixer set Master toggle > /dev/null")
    , ((noModMask, xF86XK_AudioMute), alsa_toggle_mute)
--    , ((mod4Mask, xK_V), spawn "sflock -c ' '")
    ]

myConfig
    = bepoConfig
      { workspaces  = myWorkspaces
      , modMask     = mod4Mask
      -- , terminal    = "urxvt"
      -- , terminal    = "dbus-launch gnome-terminal"
      , terminal    = "mate-terminal"
      , startupHook = setWMName "LG3D"  -- setNumLockMask 0
      } `additionalKeys` anotherKeys

myWorkspaces = ["I","II","III", "IV", "V"]

bepoConfig = defaultConfig { keys = myKeys <+> bepoKeys <+> keys defaultConfig }

myKeys conf@(XConfig {modMask = modm}) = M.fromList $
    [((modm, xK_p), spawn "dmenu_run -fn 'Fira Mono-11'")]

bepoKeys conf@(XConfig { modMask = modm }) = M.fromList $
    [((modm, xK_semicolon), sendMessage (IncMasterN (-1)))]
    ++
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (workspaces conf) [0x22,0xab,0xbb,0x28,0x29,0x40,0x2b,0x2d,0x2f,0x2a],
          (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

--------------------------------------------------------------------------------
-- Alsa controls.
--------------------------------------------------------------------------------
data Value = Pourcentage Double

applyValue :: Value -> Integer -> Integer
applyValue (Pourcentage p) v = truncate ((fromIntegral v) * (p / 100))

toggleMute :: ALSA.Mixer -> IO ()
toggleMute m = do
    r <- ALSA.getControlByName m "Master"
    case r of
        Just c -> do
            let Just b = ALSA.playback $ ALSA.switch c
            v <- ALSA.getJoined b
            ALSA.setJoined b $ not v
        _ -> fail "Can't get Master control"

decreaseVolume :: Value -> ALSA.Mixer -> IO ()
decreaseVolume volume_value m = do
    r <- ALSA.getControlByName m "Master"
    case r of
        Just c -> do
            let Just v = ALSA.playback $ ALSA.volume c
                Just s = ALSA.playback $ ALSA.switch c
            (_, mx)  <- ALSA.getRange v
            Just vol <- ALSA.getChannel ALSA.FrontRight $ ALSA.value v
            let incr    = applyValue volume_value mx
                tmp_vol = vol - incr
                new_vol = if tmp_vol < 0 then 0 else tmp_vol
            ALSA.setChannel ALSA.FrontLeft (ALSA.value v) new_vol
            ALSA.setChannel ALSA.FrontRight (ALSA.value v) new_vol

            when (new_vol == 0) $ ALSA.setJoined s False
        _ -> fail "Can't get Master control"

increaseVolume :: Value -> ALSA.Mixer -> IO ()
increaseVolume volume_value m = do
    r <- ALSA.getControlByName m "Master"
    case r of
        Just c -> do
            let Just v = ALSA.playback $ ALSA.volume c
                Just s = ALSA.playback $ ALSA.switch c
            (_, mx)  <- ALSA.getRange v
            Just vol <- ALSA.getChannel ALSA.FrontRight $ ALSA.value v
            let incr    = applyValue volume_value mx
                new_vol = min mx (vol + incr)
            ALSA.setChannel ALSA.FrontLeft (ALSA.value v) new_vol
            ALSA.setChannel ALSA.FrontRight (ALSA.value v) new_vol

            active <- ALSA.getJoined s
            when (not active) $ ALSA.setJoined s True
        _ -> fail "Can't get Master control"

--------------------------------------------------------------------------------
