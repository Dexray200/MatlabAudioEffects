%% Real-Time Audio Stream Processing
%
% The Audio System Toolbox provides real-time, low-latency processing of
% audio signals using the System objects audioDeviceReader and
% audioDeviceWriter.
%
% This example shows how to acquire an audio signal using your microphone,
% perform basic signal processing, and play back your processed
% signal.
%
% Code for stream processing
% Get the audio devices connected to computer
%% USER INPUTS
% Set audio Device Reader and user set device:
nChannels = input('Select number of Channels');
driver = input('Select driver type:','s');
deviceReader =audioDeviceReader("Driver",driver);
devices = getAudioDevices(deviceReader);
for i = 1:length(devices)
    fprintf('Device %d: ',i)
    disp(string(devices(i)))
    fprintf('\n')
end
device = input('Select Device: ','s');

for i = 1:length(devices)
    if device == string(devices(i))
        break
    end
    if i == length(devices)
        device = input("Invalid Device Select another: ",'s')
        i = 1;
    end
end

%% Set Up Input and Output Devices
deviceReader1 = audioDeviceReader("NumChannels", nChannels,"Driver",driver, ...
    'Device',device);

fs = deviceReader1.SampleRate;
deviceWriter = audioDeviceWriter('Driver',driver,'Device',device);



% playRec = audioPlayerRecorder('SampleRate',fs);

% % Filters and Signal Processing
Echo = Echo();
% Spectrum Analyzer of input sound
Spectrum = dsp.SpectrumAnalyzer('SampleRate',fs,'PlotAsTwoSidedSpectrum', ...
    false,'FrequencyScale','Log');

% Sound Pressure
scope  = timescope('SampleRate',fs, ...
    'TimeSpanOverrunAction','Scroll', ...
    'TimeSpanSource','Property','TimeSpan',3,'ShowGrid',true, ...
    'YLimits',[20 110],'AxesScaling','Auto', ...
    'ShowLegend',true,'BufferLength',4*3*fs, ...
    'ChannelNames', ...
    {'Lt_AF','Leq_A','Lpeak_A','Lmax_AF'}, ...
    'Name','Sound Pressure Level Meter');

SPL = splMeter('TimeWeighting','Fast', ...
    'FrequencyWeighting','A-weighting', ...
    'SampleRate',fs, ...
    'TimeInterval',2);

disp('Begin Signal Input...')
tic
while true
    % Read device input:
    x = deviceReader1();

    % Filter Device:
    Echo.Delay = 0.5;
    y = x;
    
    % Write to audio Device:
    deviceWriter(y);

    % Visual:
    step(Spectrum, x)
    
end
disp('End Signal Input')

release(deviceReader1)
release(deviceWriter)