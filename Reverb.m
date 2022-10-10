classdef Reverb < audioPlugin
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here

    properties
        % Delay In seconds
        Delay = 0.5
        alpha = 0.9
    end
    properties (Access = private)
        z = []
        a = [1 zeros(1,500) 0.9]
        b = 1
        fs = 44100
       
    end

    methods
        function p = Reverb()
           p.a = [1, zeros(1, round(p.Delay*p.fs)), p.alpha];
           freqz(p.b,p.a,2000)
%            [H, W] = freqz(p.b,p.a,10000,p.fs);
%            H_mag = 20*log10(abs(H));
%             subplot(2,1,1)
%             plot(W/pi,H_mag)
%             xlabel("Freqency (Hz)")
%             ylabel("Magnitude(db)")
%             subplot(2,1,2)
%             plot(W/pi,angle(H)*180/pi)
%             xlabel("Freqency (Hz)")
%             ylabel("Angle(Degrees)")
        end
        function out = process(p,in)
            [out,p.z] = filter(p.b,p.a,in,p.z);
        end
        function set.alpha(p, alpha)
            p.alpha = alpha;
            p.a = [1, zeros(1, round(p.Delay*p.fs)), p.alpha];
            p.z = []
            freqz(p.b,p.a,2000)
%             [H, W] = freqz(p.b,p.a,100,p.fs);
%             H_mag = 20*log10(abs(H));
%             subplot(2,1,1)
%             plot(W/pi,H_mag)
%             x_label("Freqency (Hz)")
%             y_label("Magnitude(db)")
%             subplot(2,1,2)
%             plot(W/pi,angle(H)*180/pi)
%             xlabel("Freqency (Hz)")
%             y_label("Angle(Degrees)")
        end
        function set.Delay(p, Delay)
            p.Delay = Delay;            
            p.a = [1, zeros(1, round(p.Delay*p.fs)), p.alpha];
            p.z = []
            freqz(p.b,p.a,2000)
%             [H, W] = freqz(p.b,p.a,100,p.fs);
%             H_mag = 20*log10(abs(H));
%             subplot(2,1,1)
%             plot(W/pi,H_mag)
%             xlabel("Freqency (Hz)")
%             ylabel("Magnitude(db)")
%             subplot(2,1,2)
%             plot(W/pi,angle(H)*180/pi)
%             xlabel("Freqency (Hz)")
%             ylabel("Angle(Degrees)")
        end
    end
end