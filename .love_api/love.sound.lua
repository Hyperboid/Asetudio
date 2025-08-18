---@meta
---@namespace love

--- This module is responsible for decoding sound files. It can't play the sounds, see love.audio for that.
love.sound = {}

--region Decoder

--- An object which can gradually decode a sound file.
---@class Decoder : Object
local Decoder = {}
--- Creates a new copy of current decoder.
--- 
--- The new decoder will start decoding from the beginning of the audio stream.
---@return Decoder
function Decoder:clone() end

--- Decodes the audio and returns a SoundData object containing the decoded audio data.
---@return SoundData
function Decoder:decode() end

--- Returns the number of bits per sample.
---@return number
function Decoder:getBitDepth() end

--- Returns the number of channels in the stream.
---@return number
function Decoder:getChannelCount() end

--- Gets the duration of the sound file. It may not always be sample-accurate, and it may return -1 if the duration cannot be determined at all.
---@return number
function Decoder:getDuration() end

--- Returns the sample rate of the Decoder.
---@return number
function Decoder:getSampleRate() end

--- Sets the currently playing position of the Decoder.
---@param offset number # The position to seek to, in seconds.
function Decoder:seek(offset) end

--endregion Decoder

--region SoundData

--- Contains raw audio samples.
--- 
--- You can not play SoundData back directly. You must wrap a Source object around it.
---@class SoundData : Data, Object
local SoundData = {}
--- Returns the number of bits per sample.
---@return number
function SoundData:getBitDepth() end

--- Returns the number of channels in the SoundData.
---@return number
function SoundData:getChannelCount() end

--- Gets the duration of the sound data.
---@return number
function SoundData:getDuration() end

--- Gets the value of the sample-point at the specified position. For stereo SoundData objects, the data from the left and right channels are interleaved in that order.
---@param i number # An integer value specifying the position of the sample (starting at 0).
---@param channel number # The index of the channel to get within the given sample.
---@return number
---@overload fun(i:number):number
function SoundData:getSample(i, channel) end

--- Returns the number of samples per channel of the SoundData.
---@return number
function SoundData:getSampleCount() end

--- Returns the sample rate of the SoundData.
---@return number
function SoundData:getSampleRate() end

--- Sets the value of the sample-point at the specified position. For stereo SoundData objects, the data from the left and right channels are interleaved in that order.
---@param i number # An integer value specifying the position of the sample (starting at 0).
---@param channel number # The index of the channel to set within the given sample.
---@param sample number # The normalized samplepoint (range -1.0 to 1.0).
---@overload fun(i:number, sample:number):void
function SoundData:setSample(i, channel, sample) end

--endregion SoundData

--- Attempts to find a decoder for the encoded sound data in the specified file.
---@param file File # The file with encoded sound data.
---@param buffer number? # The size of each decoded chunk, in bytes. (Defaults to 2048.)
---@return Decoder
---@overload fun(filename:string, buffer:number?):Decoder
function love.sound.newDecoder(file, buffer) end

--- Creates new SoundData from a filepath, File, or Decoder. It's also possible to create SoundData with a custom sample rate, channel and bit depth.
--- 
--- The sound data will be decoded to the memory in a raw format. It is recommended to create only short sounds like effects, as a 3 minute song uses 30 MB of memory this way.
---@param samples number # Total number of samples.
---@param rate number? # Number of samples per second (Defaults to 44100.)
---@param bits number? # Bits per sample (8 or 16). (Defaults to 16.)
---@param channels number? # Either 1 for mono or 2 for stereo. (Defaults to 2.)
---@return SoundData
---@overload fun(decoder:Decoder):SoundData
---@overload fun(file:File):SoundData
---@overload fun(filename:string):SoundData
function love.sound.newSoundData(samples, rate, bits, channels) end

