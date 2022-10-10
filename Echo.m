classdef Echo < audioPlugin
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
        function p = Echo()
           p.a = [1, zeros(1, round(p.Delay*p.fs)), p.alpha];
        end
        function out = process(p,in)
            [out,p.z] = filter(p.b,p.a,in,p.z);
        end
        function set.alpha(p, alpha)
            p.alpha = alpha;
            p.a = [1, zeros(1, round(p.Delay*p.fs)), p.alpha];
            p.z = []
        end
        function set.Delay(p, Delay)
            p.Delay = Delay;            
            p.a = [1, zeros(1, round(p.Delay*p.fs)), p.alpha];
            p.z = []
        end
    end
end