{-# LANGUAGE ForeignFunctionInterface #-}

module SDL.Mixer.Raw
  ( MIX_Audio
  , MIX_Mixer
  , MIX_Track
  , SDL_AudioSpec
  , SDL_AudioDeviceID
  , mixInit
  , mixLoadAudio
  , mixCreateMixerDevice
  , mixCreateTrack
  , mixSetTrackAudio
  , mixPlayTrack
  , mixSetTrackFrequencyRatio
  , mixSetTrackGain
  , loadAudio
  , mixPropPlayLoopsNumber
  ) where

import Foreign
import Foreign.C

data MIX_Audio
data MIX_Mixer
data MIX_Track
data SDL_AudioSpec

type SDL_AudioDeviceID = Word32
type SDL_PropertiesID = Word32

foreign import ccall unsafe "MIX_Init"
  mixInit
    :: IO Bool

foreign import ccall unsafe "MIX_LoadAudio"
  mixLoadAudio
    :: Ptr MIX_Mixer
    -> CString
    -> Bool
    -> IO (Ptr MIX_Audio)

foreign import ccall unsafe "MIX_CreateMixerDevice"
  mixCreateMixerDevice
    :: SDL_AudioDeviceID
    -> Ptr SDL_AudioSpec
    -> IO (Ptr MIX_Mixer)

foreign import ccall unsafe "MIX_CreateTrack"
  mixCreateTrack
    :: Ptr MIX_Mixer
    -> IO (Ptr MIX_Track)

foreign import ccall unsafe "MIX_SetTrackAudio"
  mixSetTrackAudio
    :: Ptr MIX_Track
    -> Ptr MIX_Audio
    -> IO Bool

foreign import ccall unsafe "MIX_PlayTrack"
  mixPlayTrack
    :: Ptr MIX_Track
    -> SDL_PropertiesID
    -> IO Bool

foreign import ccall unsafe "MIX_SetTrackFrequencyRatio"
  mixSetTrackFrequencyRatio
    :: Ptr MIX_Track
    -> CFloat
    -> IO Bool

foreign import ccall unsafe "MIX_SetTrackGain"
  mixSetTrackGain
    :: Ptr MIX_Track
    -> CFloat
    -> IO Bool

loadAudio
  :: Ptr MIX_Mixer
  -> FilePath
  -> Bool
  -> IO (Ptr MIX_Audio)
loadAudio mixer path predecode =
  withCString path \cstr ->
    mixLoadAudio mixer cstr predecode

mixPropPlayLoopsNumber :: String
mixPropPlayLoopsNumber = "SDL_mixer.play.loops"
