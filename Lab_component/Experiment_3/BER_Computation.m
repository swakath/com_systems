% This code finds theoritical Bit Error Rate(BER) for different SNR values 
% and compaires the results with practically calculated BER.
% Coded by S U Swakath. Last updated on 18th Nov 2020
%% Theoritical BER
SNR = 0:0.1:15; %Vector containing all SNR values for computation in dB
lengthSNR = length(SNR); %SNR vector length
BER_Theory = zeros(1,lengthSNR); %Vector to store Theoritical BER 
%Calculating Theoritical BER
for i=1:lengthSNR
    BER_Theory(i) = qfunc(sqrt(2*(10^(SNR(i)/10))));
end
semilogy(SNR,BER_Theory);%plotting the Theoritical BER
hold on

%% Practical BER
signalLen = 100000; %Length of signal
BER_Practical = zeros(1,lengthSNR);%vector to store practical BER 
signal = randi([0 1],1,signalLen);%generating signal of random 0s and 1s
nSamples = 1000; %number of iteration per SNR for BER calculation
currentBER = 0; %variable to store BER for each SNR value

%computing Practical BER 
for i = 1:lengthSNR
    for j = 1:nSamples
        %modulation of given signal for ith SNR value
        modulatedSignal = bpsk_modulation(signal,SNR(i)); 
        %demodulating the modulatedSignal
        demodulatedSignal = bpsk_demodulation(modulatedSignal);
        errorMat = signal~=demodulatedSignal;
        %adding the error for the current sample to the overall error
        currentBER = currentBER + sum(errorMat);
    end
    %Finding the average error for the current SNR
    currentBER = currentBER/nSamples;
    %Adding the final calculated BER to the vector
    BER_Practical(i) = currentBER/signalLen;
    currentBER = 0;
end

semilogy(SNR,BER_Practical); %plotting Practical BER.
hold off
title("Bit Error Rate vs SNR");
xlabel("SNR dB");
ylabel("Bit Error Rate (log Scale)");
legend("Theoretical BER", "Practical BER");