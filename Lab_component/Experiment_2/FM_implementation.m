%This code is performs FM modulations and demodulation of a given message
%signal. Coded by S U Swakath. Last Updated 18th Nov 2020
close all;clear all;
%% GENERATING AN ANALOG MESSAGE SIGNAL
Am = 4; %message signal amplitude
Fm = 100; %message signal frequency in Hz
Fs = 10000; %sampling frequency in Hz

% Define number of cycles and the time vector
ncycles = 4;
t = 0: 1/Fs : (ncycles/Fm - 1/Fs);

messageSignal = Am*cos(2*pi*Fm*t); %defining message signal;
messageLen = numel(messageSignal); %mesage signal length 

message_fft = fftshift(fft(messageSignal));%DFT of message signal
message_fft = message_fft/messageLen;
Nfft = length(message_fft); %N value of N point dft
F_plot = Fs*(-Nfft/2:Nfft/2-1)/Nfft; %Frequency vector for plot

% Plotting the time domain and frequency domain plot of the message signal
figure(1);
subplot(211);
plot(t, messageSignal); % Time domain plot
title('Message Signal (Time domain)');
xlabel('Time');
ylabel('Magnitude');
subplot(212);
plot(F_plot,abs(message_fft)); % Frequency domain plot
title('Message Signal (Frequency domain)');
xlabel('frequency');
ylabel('Magnitude');
%% FREQUENCY MODULATION

% Generating the modulated phase shift for the passband signal
theta = zeros(1, messageLen);
kf = 100;% Define constant Kf
Ac = 5; % Carrier wave ampitude
Fc = 1000; %Carrier wave frequency in Hz

for i = 1:messageLen
    % Numerically integrating the messageSignal, (that is summation)
    theta(i) = 2*pi*kf*sum(messageSignal(1:i))/(Fs);
end

% Generating the Passband signal
passbandSignal = Ac*cos(2*pi*Fc*t + theta);

% Computing DFT of Passband signal
passband_fft  = fftshift(fft(passbandSignal));
passband_fft  = passband_fft/length(passbandSignal);

% Plotting the time domain and frequency domain plot of the Passband signal
figure(2)
subplot(211);
plot(t, passbandSignal); % Time domain plot
title('FM Passband Signal (Time domain)');
xlabel('Time');
ylabel('Magnitude');
subplot(212);
plot(F_plot, abs(passband_fft)); % frequency domain plot
title('FM Passband Signal (Frequency domain)');
xlabel('Frequency');
ylabel('Magnitude');

%% FREQUENCY DEMODULATION

% Differentiating the passband signal
derivative = diff(passbandSignal)*Fs;
derivative = [0 derivative];

% Computing the envelope of the derivative signal using hilbert transform
envelope = abs(hilbert(derivative));

% Plotting the time domain of derivative signal and its envelope 
figure(3);
subplot(211);
plot(t, derivative); % Plotting derivative signal
title('Derivative of the Passband Signal');
xlabel('Time');
ylabel('Magnitude');

subplot(212);
plot(t, derivative);
hold on
plot(t,envelope); % Plotting the derivative signal's envelope
hold off
title('Envelope of the Derivative');
xlabel('Time');
ylabel('Magnitude');
legend(["Derivative","Envelope"],'location','southeast')

% Removing scaling factors
demodulatedSignal = (envelope/(2*pi) )/(kf*Ac);

% Finding the DC offset using fft
temp = fft(demodulatedSignal)/length(demodulatedSignal);

%Removing the DC offset from the demodulatedSignal
demodulatedSignal = demodulatedSignal - temp(1);

%Computing the DFT of the demodulated signal
demodulated_fft = fftshift(fft(demodulatedSignal));
demodulated_fft = demodulated_fft/length(demodulatedSignal);

% Plotting the time domain and frequency domain plot of demodulated signal
figure(4)
subplot(211);
plot(t, demodulatedSignal); % Time domain 
title('Demodulated Signal (Time domain)');
xlabel('Time');
ylabel('Magnitude');

subplot(212);
plot(F_plot, abs(demodulated_fft)); %Frequency domain
title('Demodulated Signal (Frequency domain)');
xlabel('Frequency');
ylabel('Magnitude');