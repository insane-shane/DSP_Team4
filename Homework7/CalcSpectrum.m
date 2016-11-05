function [pwrSpectrum, freqVec] = CalcSpectrum(sig,fs,varargin)
    if nargin < 3 % No optional arguments
        N = length(sig);
    else
        N = varargin{1};
    end

    % Convert to frequency domain and get the power
    sigFreqDom = fftshift(fft(sig,N));
    pwrSpectrum = (abs(sigFreqDom)./N).^2;

    % Generate the frequency vector
    df = fs/N;
    freqVec = -fs/2:df:(fs/2 - df);
end