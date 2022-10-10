classdef Equalizer < audioPlugin
% Copyright 2016 The MathWorks, Inc. 
  properties    
    % public interface
    % 3 peak gain (in dB)    
    LowGain = 0
    MidGain = 0
    HighGain = 0

    % Center Frequacies
    LowFc = 100
    MidFc = 1000
    HighFc = 10000
  end
    
  properties (Access = private)
    % internal state
    z = zeros(2)
    b1 = [1, zeros(1,2)]
    a1 = [1, zeros(1,2)]
    b2 = [1, zeros(1,2)]
    a2 = [1, zeros(1,2)]
    b3 = [1, zeros(1,2)]
    a3 = [1, zeros(1,2)]
    fs = 44100
  end
  
  methods
    function p = Equalizer()
        [p.b1, p.a1] = PeakingEQCoeffs(p.LowGain, p.LowFc, p.fs);
        [p.b2, p.a2] = PeakingEQCoeffs(p.MidGain, p.MidFc, p.fs);
        [p.b3, p.a3] = PeakingEQCoeffs(p.HighGain, p.HighFc, p.fs);
        H1 = dfilt.df2t(p.b1,p.a1);
        H2 = dfilt.df2t(p.b2,p.a2);
        H3 = dfilt.df2t(p.b3,p.b3);
        Hcas = dfilt.cascade(H1,H2,H3);
        freqz(Hcas)
    end
    function out = process(p, in)
        H1 = dfilt.df2t(p.b1,p.a1);
        H2 = dfilt.df2t(p.b2,p.a2);
        H3 = dfilt.df2t(p.b3,p.b3);
        Hcas = dfilt.cascade(H1,H2,H3);
        out = filter(Hcas,in);

    end
    
    function set.LowFc(p, LowFc)
      p.LowFc = LowFc;
      Fs = getSampleRate(p);
      [p.b1, p.a1] = PeakingEQCoeffs(p.LowGain, LowFc, Fs); 
        H1 = dfilt.df2t(p.b1,p.a1);
        H2 = dfilt.df2t(p.b2,p.a2);
        H3 = dfilt.df2t(p.b3,p.b3);
        Hcas = dfilt.cascade(H1,H2,H3);
        freqz(Hcas)
    end

    function set.MidFc(p,MidFc)
      p.MidFc = MidFc;
      Fs = getSampleRate(p);
      [p.b2, p.a2] = PeakingEQCoeffs(p.MidGain, MidFc, Fs);
        H1 = dfilt.df2t(p.b1,p.a1);
        H2 = dfilt.df2t(p.b2,p.a2);
        H3 = dfilt.df2t(p.b3,p.b3);
        Hcas = dfilt.cascade(H1,H2,H3);
        freqz(Hcas)
    end

    function set.HighFc(p,HighFc)
      p.HighFc = HighFc;
      Fs = getSampleRate(p);
      [p.b3, p.a3] = PeakingEQCoeffs(p.HighGain, HighFc, Fs);
        H1 = dfilt.df2t(p.b1,p.a1);
        H2 = dfilt.df2t(p.b2,p.a2);
        H3 = dfilt.df2t(p.b3,p.b3);
        Hcas = dfilt.cascade(H1,H2,H3);
        freqz(Hcas)
    end

    function set.LowGain(p,LowGain)
       p.LowGain = LowGain;
       Fs = getSampleRate(p);
       [p.b1,p.a1] = PeakingEQCoeffs(LowGain,p.LowFc,Fs);
        H1 = dfilt.df2t(p.b1,p.a1);
        H2 = dfilt.df2t(p.b2,p.a2);
        H3 = dfilt.df2t(p.b3,p.b3);
        Hcas = dfilt.cascade(H1,H2,H3);
        freqz(Hcas)
    end

    function set.MidGain(p,MidGain)
        p.MidGain = MidGain;
        Fs = getSampleRate(p);
        [p.b2,p.a2] = PeakingEQCoeffs(MidGain,p.MidFc,Fs);
        H1 = dfilt.df2t(p.b1,p.a1);
        H2 = dfilt.df2t(p.b2,p.a2);
        H3 = dfilt.df2t(p.b3,p.b3);
        Hcas = dfilt.cascade(H1,H2,H3);
        freqz(Hcas)
    end

    function set.HighGain(p,HighGain)
        p.HighGain = HighGain;
        Fs = getSampleRate(p);
        [p.b1,p.a1] = PeakingEQCoeffs(HighGain,p.HighFc,Fs);
        H1 = dfilt.df2t(p.b1,p.a1);
        H2 = dfilt.df2t(p.b2,p.a2);
        H3 = dfilt.df2t(p.b3,p.b3);
        Hcas = dfilt.cascade(H1,H2,H3);
        freqz(Hcas)
    end

  end
  
end
