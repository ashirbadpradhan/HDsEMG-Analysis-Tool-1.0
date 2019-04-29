function y = update_fft(signal, windowlength, overlap, zeropad,state,channel)

delta = windowlength - overlap;

indices = 1:delta:length(signal);
% Zeropad signal
if length(signal) - indices(end) + 1 < windowlength
    if zeropad
        signal(end+1:indices(end)+windowlength-1) = 0;
    else
        indices = indices(1:find(indices+windowlength-1 <= length(signal), 1, 'last'));
    end
end

fs=1000;
N=windowlength/fs;
t=(1/fs:0.001:N);                                                % Time Vector
%s = signal(i:i+windowlength-1);                                              % Signal Vector
Fs = 1/mean(diff(t));                                   % Sampling Frequency
Fn = Fs/2;                                              % Nyquist Frequency
L = length(t);
FTs = signal/L;
Fv = linspace(0, 1, fix(L/2)+1)*Fn;                     % Frequency Vector
Iv = 1:length(Fv);                                      % Index Vector
CumAmp = cumtrapz(Fv, abs(FTs(Iv)));                    % Integrate FFT Amplitude
MedFreq = interp1(CumAmp, Fv, CumAmp(end)/2);
y=MedFreq;

%% plot
plot(Fv, abs(FTs(Iv))*2, '-b')                          % Plot FFT
hold on
%plot(Fv, CumAmp, '-g')                                  % Plot Cumulative Amplitude Integral
plot([MedFreq MedFreq], ylim, '-r', 'LineWidth',1)      % Plot Median Frequency
hold off
xlabel('Frequency(Hz)');
ylabel('Magnitude (V)');
title('Magnitude Spectrum in Hz');
axis tight
end