function [b,a] = NotchCoeffs(Fc,Fs)
    % H(s)= (s^2+s(A/Q)+1)/(s^2+(s/AQ)+1)
    % Quality factor Q:
%    * 1/sqrt(2) (default) is a Butterworth filter, with maximally-flat
%      passband
%    * 1/sqrt(3) is a Bessel filter, with maximally-flat group delay.
%    * 1/2 is a Linkwitz-Riley filter, used to make lowpass and highpass
%     sections that sum flat to unity gain.
    w0 = 2*pi*(Fc/Fs);
    alpha = sin(w0)/sqrt(2); % Butterworth alpha
    
    cosw0 = cos(w0);
    norm = 1/(1+alpha);
    b = [1*norm -2*cosw0*norm 1*norm];
    a = [(1 + alpha)*norm  -2*cosw0*norm  (1 - alpha)*norm];
end