% This code computes Bit Error Rate (BER) vs SNR plot for DQPSK modulation
% scheme with gray labelling in Additive White Gaussain Noise. Plots the
% theoritical and simulation results.
%% Theoritical BER
SNR = 0:0.1:15; %Vector containing all SNR values for computation in dB
lengthSNR = length(SNR); %SNR vector length
BER_Theory = zeros(1,lengthSNR); %Vector to store Theoritical BER 
%Calculating Theoritical BER
for i=1:lengthSNR
    curSNR = (10^(SNR(i)/10));
    a = sqrt(2*curSNR*(1-(1/sqrt(2))));
    b = sqrt(2*curSNR*(1+(1/sqrt(2))));
    BER_Theory(i) = marcumq(a,b) -0.5*besseli(0,(a*b))*exp(-0.5*(a^2+b^2));
end
%% Simulation
len = 100000-1; % Length of the message signal (must be a even number)
message = randi([0 1],1,len); % Defining the message signal 
SNR = 0:0.1:15; % Defining SNR vector in dB
snrLen = length(SNR); % Length of SNR vector
BER_Computed = zeros(1,snrLen); % vVector to store BER for each SNR value
Itr = 100; % Number of samples taken to calculate BER for each SNR value

% Computing the BER for each SNR value
for i = 1:snrLen
    error = 0;
    % Calculating BER by taking Itr number of samples 
    for j = 1:Itr
        % Computing the modulated signal
        modulatedSignal = DQPSK_Modulation(message,SNR(i));
        % Computing the demodulated signal
        demodulatedSignal = DQPSK_Demodulation(modulatedSignal);
        % Finding the error for the current sample
        errorArr = message~=demodulatedSignal;
        error = error + sum(errorArr);
    end
    % Finding the average error accross Itr no# of sample and storing it in
    % the BER vector
    BER_Computed(i) = error/(Itr*len);
    if(mod(i,5)==0)
        disp(i);
    end
end

disp("Now Plotting");
%% Plotting the graph
figure(1)
semilogy(SNR,BER_Computed)
hold on
semilogy(SNR,BER_Theory)
hold off
title("BER vs SNR for DQPSK");
xlabel("SNR (dB)");
ylabel("BER (in log scale)");
legend('Simulation','Theoritical');