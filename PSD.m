clc;clear all;close all;
%load datafid= fopen('acc.txt');
fid= fopen('acc.txt');
rawphone =textscan(fid,'%s %s %f %f %f');  
data1=cell2mat(rawphone (1,3)) ;
data2=cell2mat(rawphone (1,4)) ;
data3=cell2mat(rawphone (1,5)) ;
varA =sqrt( var(data1)^2+var(data2)^2+var(data3) ^2);
x =data3;
fs = 5;%sampling frequency
% signal length
N = length(x);
% time vector
t = (0:N-1)/fs;
% remove the DC component
x = x - mean(x);
% PSD (Power Spectral Density ,Vrms^2/Hz)
% [PSD,F] = PWELCH(X,WINDOW,NOVERLAP,NFFT,Fs)
win = hanning(512, 'periodic');
[PSD, f] = pwelch(x, win, 256, N, fs, 'onesided');
%plot
figure()
plot(f,PSD,'k');title('功率谱');xlabel('频率');ylabel('功率');
grid on;