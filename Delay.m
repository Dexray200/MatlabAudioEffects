classdef Delay < audioPlugin
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here

    properties
        % Delay In seconds
        DelayNum = 0.01
        alpha = 1
    end
    properties (Access = private)
        z = []
        a = [1 zeros(1,500) 0.9]
        b = [1 zeros(1,500) 0.9]
        fs = 44100
       
    end

    methods
        function p = Delay()
           p.b = [1, zeros(1, round(p.DelayNum*p.fs)), p.alpha];
           freqz(p.b,p.a,round(p.DelayNum*p.fs),'whole',p.fs)
%            [H, W] = freqz(p.b,p.a,2000);
% %            H_mag = 20*log10(abs(H));
% %            plot(W/pi,H_mag)
        end
        function out = process(p,in) 
            [out,p.z] = filter(p.b,p.a,in,p.z);
        end
        function set.alpha(p, alpha)
            p.alpha = alpha;
            p.b = [1, zeros(1, round(p.DelayNum*p.fs)), p.alpha];
            p.z = []
            [H, W] = freqz(p.b,p.a,2000, p.fs);
            H_mag = 20*log10(abs(H));
            plot(W/pi,H_mag)
        end
        function set.DelayNum(p, Delay)
            p.DelayNum = Delay;
            Fs = getSampleRate(p);
            p.b = [1, zeros(1, round(p.DelayNum*Fs)), p.alpha];
            p.z = []
            [H, W] = freqz(p.b,p.a,2000, p.fs);
            H_mag = 20*log10(abs(H));
            plot(W/pi,H_mag)
        end
    end
end