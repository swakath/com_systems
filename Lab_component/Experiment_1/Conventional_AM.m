%Code to performing conventional AM 
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
amod = 0.1; %Modulation index (amod<=1)
fc = 1000; %Carrier frequency in Hz
[yc,carrier] = modulation(ym,amod,fc,t); %Computing modulated signal
Yc_fft = fftshift(fft(yc))/length(yc);%modulated signal dft

%plotting Passband signal time domain and frequency domain plots
figure(2)
subplot(2,1,1)
plot(t,yc,'b')
hold on
plot(t,ym,'r')
hold off
title("Modulated signal (Time domain)")
xlabel("time(s)")
ylabel("Amplitude")
legend("Modulated signal", "Message signal");

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
demodulatedSignal = demodulation(yc,fc,fs,t); %computing demodulated signal
demodulatedSignal_fft = fftshift( fft(demodulatedSignal)); 
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
function [modulatedSignal,carrierSignal] = modulation(signal,a_mod,fc,t)
%This function takes a signal in time domain signal and computes its
%corresponding modulatedSignal using conventional AM modulation scheme.
%To compute the modulatedSignal the function takes a_mod (a_mod<=1),
%carrier wave frequency (fc) in Hz and time vector (t) in s
    
    min_signal = min(signal); %minimum value of the given signal
    Ac = (abs(min_signal))/a_mod; %carrier wave amplitude
    modulatedSignal = Ac*((1+a_mod*signal).*(cos(2*pi*fc*t)));%modulation 
    carrierSignal = Ac*(cos(2*pi*fc*t));%carrier wave
end

function [demodulatedSignal] = demodulation(passbandSignal,fc,fs,t)
%This function takes passbandSignal of conventional AM modulation  
%and demodulates the signal using coherent detection.
%The carrier frequency is fc. A 4th order butterworth filter is used as 
%a low pass filter with cutoff as fc. DC value offset and gain is 
%eliminated to generate the original signal.
    temp = 2*passbandSignal.*cos(2*pi*fc*t); 
    temp_fft = fft(temp)/length(temp);
    temp = temp - temp_fft(1);%removing DC offset
    [b,a] = butter(4,fc*2/(fs),'low'); %low pass filter
    demodulatedSignal = filter(b,a,temp); 
    gain = min(demodulatedSignal);
    gain = sqrt(abs(gain));
    demodulatedSignal = demodulatedSignal/gain;%removing the gain 
end
