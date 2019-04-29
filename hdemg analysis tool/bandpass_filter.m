function y = bandpass_filter(Data)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
%% Filter the signal using 4th order butterworth filter
n=size(Data,2);
[b a] = butter(4,[0.04 0.9],'bandpass');
for j=1:n
    x_filtered(:,j)=filter(b,a,Data(:,j));
end
y=x_filtered;
end

