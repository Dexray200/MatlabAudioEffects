classdef Phaser < audioPlugin
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
        function out = process(p,in) 
            [out,p.z] = filter(p.b,p.a,in,p.z);

        end

        function set.Delay(p, Delay)
            p.Delay = Delay;
            Fs = getSampleRate(p);
            p.a = [1, zeros(1, round(p.Delay*Fs)), p.alpha];
        end
    end
end