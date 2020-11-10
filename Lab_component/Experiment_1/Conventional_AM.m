%Code performing conventional AM 
% Coded by S U Swakath
%% Generating message signal
clc;clear all;close all;
fm = 200 ; %message signal frequency
fs = 6000; %sampling frequency
T = 1/fm; %Message signal time period
nCycles = 10; %number of cycles of message signal taken
t = 0:1/fs:((T*nCycles)-(1/fs));
Am = 5; %message amplitude

ym = Am*sin(2*pi*2*fm*t)+ Am*cos(2*pi*fm*t);  %Message signal
%% --------Frequency and Time domain Plot of MessageSignal-----------

%computing frequency domain representation of ym
Ym_fft = fftshift(fft(ym))/length(ym);
Nfft = length(Ym_fft);
f = fs*(-Nfft/2:Nfft/2-1)/Nfft;

%time domain plot plot of message signal
figure(1)
subplot(2,1,1)
plot(t,ym)
title("Message signal in time domain")
xlabel("Time")
ylabel("Amplitude")

%frequency domain plot of message signal
subplot(2,1,2)
plot(f,abs(Ym_fft))
title("Message signal in frequency domain")
xlabel("frequency(Hz)")
ylabel("Amplitude")

%% -----------Performing AM Modulation--------------- 
amod = 0.1; % modulation index (amod<=1)
fc = 1000; %carrier frequency in Hz
yc = modulation(ym,amod,fc,t);
Yc_fft = fftshift(fft(yc))/length(yc);

figure(2)
subplot(2,1,1)
plot(t,yc,'b')
hold on
plot(t,ym,'r')
hold off
title("Passband AM signal in time domain")
xlabel("time")
ylabel("Amplitude")
legend("Passband signal", "Message signal");
subplot(2,1,2)
plot(f,abs(Yc_fft))
title("Passband AM signal in frequency domain")
xlabel("frequency")
ylabel("Amplitude")

%% -----------Performing AM demodulation--------
receivedSignal = demodulation(yc,fc,fs,t);
receivedSignal_fft =fftshift( fft(receivedSignal))/length(receivedSignal);
w = (0:(2*pi)/Nfft:2*pi*(1-1/Nfft))/pi;

figure(3)
subplot(2,1,1)
plot(t,receivedSignal);
title("Received Signal in time domain");
xlabel("time");
ylabel("Amplitude");
subplot(2,1,2)
plot(f,abs(receivedSignal_fft))
title("Received Signal in time domain");
xlabel("frequency");
ylabel("Amplitude");

%phase plots
% figure(4)
% subplot(2,1,1)
% plot(f,angle(Ym_fft))
% subplot(2,1,2)
% plot(f,angle(receivedSignal_fft))

%% -----------Functions------------
function [modulatedSignal] = modulation(signal,a_mod,fc,t)
    min_signal = min(signal);
    Ac = (abs(min_signal))/a_mod;
    disp('as');
    disp(Ac);
    modulatedSignal = Ac*((1+a_mod*signal).*(cos(2*pi*fc*t)));
end

function [demodulatedSignal] = demodulation(passbandSignal,fc,fs,t)
    temp = 2*passbandSignal.*cos(2*pi*fc*t);
    temp_fft = fft(temp)/length(temp);
    temp = temp - temp_fft(1);
    disp(temp_fft(1));
    [b,a] = butter(4,fc*2/(fs),'low');
    demodulatedSignal = filter(b,a,temp);
    gain = min(demodulatedSignal);
    gain = sqrt(abs(gain));
    demodulatedSignal = demodulatedSignal/gain;
end
