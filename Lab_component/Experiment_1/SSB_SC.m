%Code to performing SSB_SC 
%Coded by S U Swakath
%% --------- Generating message signal ----------------
clc;clear all;close all;
fm = 200 ; %Message signal frequency in Hz
fs = 6000; %Sampling frequency in Hz
T = 1/fm; %Message signal time period in s
nCycles = 10; %Number of cycles of message signal
t = 0:1/fs:((T*nCycles)-(1/fs));
Am = 5; %Message signal amplitude

ym = Am*sin(2*pi*2*fm*t)+ Am*cos(2*pi*fm*t);  %Message signal

%% --------Frequency and Time domain Plot of Message signal-----------
%computing frequency domain representation of ym
Ym_fft = fftshift(fft(ym))/length(ym); %dft of message signal
Nfft = length(Ym_fft); %N value of N point dft
f = fs*(-Nfft/2:Nfft/2-1)/Nfft; %frequency vector for plot

%time domain plot plot of message signal
figure(1)
subplot(2,1,1)
plot(t,ym)
title("Message signal (Time domain)")
xlabel("time(s)")
ylabel("Amplitude")

%frequency domain plot of message signal
subplot(2,1,2)
plot(f,abs(Ym_fft))
title("Message signal (Frequency domain)")
xlabel("frequency(Hz)")
ylabel("Amplitude")

%% -----------Performing AM Modulation--------------- 
fc = 1000; %Carrier frequency in Hz
[yc,carrier] = modulation(ym,fc,t); %Computing modulated signal 

Yc_fft = fftshift(fft(yc))/length(yc);%modulated signal dft

%plotting Passband signal time domain and frequency domain plots
figure(2)
subplot(2,1,1)
plot(t,yc,'b')
title("Modulated signal (Time domain)")
xlabel("time(s)")
ylabel("Amplitude")

subplot(2,1,2)
plot(f,abs(Yc_fft))
title("Modulated signal (Frequency domain)")
xlabel("frequency(Hz)")
ylabel("Amplitude")

figure(3)
plot(t,carrier);
title('Carrier Signal (Time domain)')
xlabel('time(s)')
ylabel('Amplitude')

%% -----------Performing AM demodulation--------
demodulatedSignal = demodulation(yc,fc,fs,t); %computing received signal
demodulatedSignal_fft =fftshift( fft(demodulatedSignal));
demodulatedSignal_fft = demodulatedSignal_fft/length(demodulatedSignal);

%plotting received signal, time domain and frequency domain plots
figure(4)
subplot(2,1,1)
plot(t,demodulatedSignal);
title("Demodulated Signal (Time domain)");
xlabel("time(s)");
ylabel("Amplitude");
subplot(2,1,2)
plot(f,abs(demodulatedSignal_fft))
title("Demodulated Signal (Frequency domain)");
xlabel("frequency(Hz)");
ylabel("Amplitude");

disp('computation completed')

%% --------------- Functions ------------------
function [modulatedSignal,carrierSignal] = modulation(signal,fc,t)
%This function takes a signal in time domain signal and computes its
%corresponding modulatedSignal using SSB-SC modulation scheme.
%Lower side band SSB-SC is performed using this function.
%To compute the modulatedSignal the function takes, carrier wave 
%frequency(fc) in Hz and time vector (t) in s.
    hilbert_signal =  imag(hilbert(signal));  
    modulatedSignal= signal.*cos(2*pi*fc*t)+hilbert_signal.*sin(2*pi*fc*t);
    carrierSignal = cos(2*pi*fc*t);
end

function [demodulatedSignal] = demodulation(passbandSignal,fc,fs,t)
%This function takes passbandSignal of SSB-SC modulation  
%and demodulates the signal using coherent detection.
%The carrier frequency is fc. A 4th order butterworth filter is used as 
%a low pass filter with cutoff as fc.
    temp = 2*passbandSignal.*cos(2*pi*fc*t);%coherent detection
    [b,a] = butter(4,fc*2/(fs),'low');%butterworth filter
    demodulatedSignal = filter(b,a,temp);%applying butterworth filter
end
