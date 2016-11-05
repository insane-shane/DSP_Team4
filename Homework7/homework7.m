% Sine wave detector
clear
close all
format shortEng

%% ===== Input parameters =====
% Sine wave frequencies
f = [50e3, 100e3, 200e3];

% Amplitudes
A = [2, 2, 2];

% SNR generation
desSNRdB = 3; % SNR in dB
desSNR = 10^(desSNRdB/10);

sigPower = (sum(A.^2))/2;
noisePower = sigPower/desSNR;

% Signal generation in the time domain
fs = 1e6; % Sampling frequency
N = 2^13; % 8k samples
Ts = 1/fs;
tvec = 0:Ts:(N-1)*Ts;

sig = zeros(1,N);
for sigNum = 1:length(f)
    sig = sig + A(sigNum)*sin(2*pi*f(sigNum)*tvec);
end
noise = sqrt(noisePower)*randn(1,N);
waveform = sig+noise;
fprintf('SNR = %0.2fdB\n', snr(sig,noise)); % sanity check for SNR

% Convert to the frequency domain
[spect, freqVec] = CalcSpectrum(waveform,fs,N);
spect = 2*spect(N/2:end);
freqVec = freqVec(N/2:end);
spectdB = 10*log10(spect);

% Plot to make sure we have some stuff
figure(); hold on; grid on;
xlabel('Frequency (Hz)'); ylabel('Amplitude (dB)');
plot(freqVec, spectdB);

%% Simple threshold detector
thresh = -3; % in dB
detFreqs = ThreshDetector(spectdB,freqVec,thresh);
fprintf('Detected frequencies:\n');
fprintf('%0.2e Hz\n', detFreqs);
