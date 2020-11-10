%Code to perform DSB_SC
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
Ac = 10; %Carrier frequency amplitude
fc = 1000; %Carrier frequency in Hz
[yc,carrier] = modulation(ym,Ac,fc,t); %Computing modulated signal 
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
demodulatedSignal = demodulation(yc,Ac,fc,fs,t); %computing received signal
demodulatedSignal_fft = fftshift(fft(demodulatedSignal))/length(demodulatedSignal);
w = (0:(2*pi)/Nfft:2*pi*(1-1/Nfft))/pi;

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

%phase plots
% figure(5)
% subplot(2,1,1)
% plot(f,angle(Ym_fft))
% subplot(2,1,2)
% plot(f,angle(demodulatedSignal_fft))
disp('computation completed')

%% --------------- Functions ------------------
function [modulatedSignal,carrierSignal] = modulation(signal,Ac,fc,t)
    modulatedSignal = Ac*(signal).*(cos(2*pi*fc*t));
    carrierSignal = Ac*(cos(2*pi*fc*t));
end

function [demodulatedSignal] = demodulation(passbandSignal,Ac,fc,fs,t)
    temp = 2*passbandSignal.*cos(2*pi*fc*t);
    [b,a] = butter(4,fc*2/(fs),'low');
    demodulatedSignal = filter(b,a,temp);
    demodulatedSignal = demodulatedSignal/Ac;
end
