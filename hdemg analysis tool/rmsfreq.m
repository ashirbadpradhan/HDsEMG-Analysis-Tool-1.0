function y = rmsfreq(signal, windowlength, overlap, zeropad)

delta = windowlength - overlap;
indices = 1:delta:length(signal);

y = zeros(1, length(indices));
index = 0;
index_mdf = [];
fs=1000;
N=windowlength;
N_2=ceil(N/2);

% Zeropad signal
if length(signal) - indices(end) + 1 < windowlength
    if zeropad
        signal(end+1:indices(end)+windowlength-1) = 0;
    else
        indices = indices(1:find(indices+windowlength-1 <= length(signal), 1, 'last'));
    end
end

index = 0;
for i = indices
    N=windowlength/fs;
    index = index+1;
    t=(1/fs:0.001:N);                                                % Time Vector
    s = signal(i:i+windowlength-1);                                              % Signal Vector
    Fs = 1/mean(diff(t));                                   % Sampling Frequency
    Fn = Fs/2;                                              % Nyquist Frequency
    L = length(t);
    FTs = fft(s)/L;
    Fv = linspace(0, 1, fix(L/2)+1)*Fn;                     % Frequency Vector
    Iv = 1:length(Fv);                                      % Index Vector
    CumAmp = cumtrapz(Fv, abs(FTs(Iv)));                    % Integrate FFT Amplitude
    MedFreq = interp1(CumAmp, Fv, CumAmp(end)/2);
    % Average and take the square root of each window
    y(index) = MedFreq;
end
%% plot
x=linspace(1,size(signal,1),length(y));
plot(x,y,'r');
xlabel('Time');
ylabel('Median Frequency (Hz)');
title('Median Freq. Plot');
%axis tight


end