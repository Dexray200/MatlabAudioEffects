classdef Flanger < audioPlugin
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here

    properties
        % Delay In seconds
        DelayMax = 0.5
        alpha = 0.9
    end
    properties (Access = private)
        a = 1
        b = 1
        dn
        fs = 44100    
        z = []
        delay = 0
        n = 0;
    end

    methods
        function p = Flanger()
        end
        function out = process(p,in)
            [p.delay,p.z] = filter(p.b,p.a,in,p.z);
            out = in + p.delay;
            oscillator = (1-cos(p.n));
            p.dn = p.fs*(p.DelayMax/2)*oscillator;
            p.b = [1, zeros(1, round(p.dn)), p.alpha];
            p.n = p.n + 0.3;
        end
        function set.alpha(p, alpha)
            p.alpha = alpha;
            p.a = [1, zeros(1, round(p.Delay*p.fs)), p.alpha];
            p.z = []
        end
        function set.DelayMax(p, Delay)
            p.Delay = Delay;            
            p.a = [1, zeros(1, round(p.Delay*p.fs)), p.alpha];
            p.z = []
        end
    end
end