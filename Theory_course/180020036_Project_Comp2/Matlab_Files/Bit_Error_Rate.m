%Code to find Bit Error Rate vs SNR graph
clear;clc;
%Creating a signal of length equal to N
a = 2;  % a value for modulation
N = 1000;   % length of the signal
signal = randi([0 1],1,N); %creating random signal containing bit1 and bit0

modulatedSignal = modulation(signal,a); %finding the modulated signal
SNR = 1:0.1:20; %different values of SNR for the plot
errorSNR = []; %array containing BER corresponding to each SNR
sampleSize = 1000; %Number of sample taken to calculate the error 

%Finding the BER for each SNR value
for i = 1:0.1:20
    fprintf("SNR %0.2f ....\n",i);
    error = 0;
    for j = 1:sampleSize
        receivedSignal = channel(modulatedSignal,i);
        finalSignal = demodulation(receivedSignal);
        allError = finalSignal~=signal;
        error = error + sum(allError)/size(allError,2);
    end
    error = error/sampleSize;
    errorSNR = [errorSNR error];
end

%Plotting the BER  vs SNR graph
plot(SNR,errorSNR);
xlabel("SNR dB");
ylabel("Bit Error Rate")
title("Bit Error Rate vs SNR");