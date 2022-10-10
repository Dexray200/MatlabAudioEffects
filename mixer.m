%% Real-Time Audio Stream Processing
%
% The Audio System Toolbox provides real-time, low-latency processing of
% audio signals using the System objects audioDeviceReader and
% dsp.AudioFileWriter.
%
% This example shows how to acquire an audio signal using your microphone,
% perform basic signal processing, and write your signal to a file.
%


deviceReader = audioDeviceReader("NumChannels",2);
fileWriter = dsp.AudioFileWriter('SampleRate',deviceReader.SampleRate);

process = @(x) x.*5;

disp('Begin Signal Input...')
tic
while toc<5
    mySignal = deviceReader();
    myProcessedSignal = process(mySignal);
    fileWriter(myProcessedSignal);
end
disp('End Signal Input')

release(deviceReader)
release(fileWriter)