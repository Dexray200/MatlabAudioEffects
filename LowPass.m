classdef LowPass < audioPlugin
% Copyright 2016 The MathWorks, Inc. 
  properties    
    % public interface
    Fc = 1000
  end
    
  properties (Access = private)
    % internal state
    z = zeros(2)
    b = [1, zeros(1,2)]
    a = [1, zeros(1,2)]
  end
  
  properties (Constant)
        PluginInterface = audioPluginInterface(audioPluginParameter('Fc','Label', ...
            'Hz', 'Mapping', {'lin',10,20000}, 'Style','rotary','Layout',[1,1]), ...
            audioPluginGridLayout);
  end
  methods
      
    function out = process(p, in)
      [out,p.z] = filter(p.b, p.a, in, p.z);
    end
    
    function reset(p)
      % initialize internal state
      p.z = zeros(2);
      Fs = getSampleRate(p);
      [p.b, p.a] = highPassCoeffs(p.Fc, Fs);
      freqz(p.b,p.a)
    end
    
    function set.Fc(p, Fc)
      p.Fc = Fc;
      Fs = getSampleRate(p);
      [p.b, p.a] = LowPassCoeffs(Fc, Fs);
      freqz(p.b,p.a,[],Fs)
    end
    
  end
  
end
