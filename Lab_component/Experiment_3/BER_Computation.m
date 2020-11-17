% This code finds theoritical Bit Error Rate(BER) for different SNR values 
% and compaires the results with practically calculated BER.

%% Theoritical BER
SNR = 0:0.1:15;
lengthSNR = length(SNR);
BER_Theory = zeros(1,lengthSNR);
for i=1:lengthSNR
    BER_Theory(i) = qfunc(sqrt((10^(SNR(i)/10))));
end
semilogy(SNR,BER_Theory);
hold on

%% Practical BER
signalLen = 100000;
BER_Practical = zeros(1,lengthSNR);
signal = randi([0 1],1,signalLen);
nSamples = 100;
currentBER = 0;

for i = 1:lengthSNR
    for j = 1:nSamples
        modulatedSignal = bpsk_modulation(signal,SNR(i));
        demodulatedSignal = bpsk_demodulation(modulatedSignal);
        errorMat = signal~=demodulatedSignal;
        currentBER = currentBER + sum(errorMat);
    end
    currentBER = currentBER/nSamples;
    BER_Practical(i) = currentBER/signalLen;
    currentBER = 0;
end

semilogy(SNR,BER_Practical);
hold off
title("Bit Error Rate vs SNR");
xlabel("SNR dB");
ylabel("Bit Error Rate (log Scale)");
legend("Theoretical BER", "Practical BER");