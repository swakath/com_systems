% This function performs DQPSK modulation using gray labelling on the given
% signal and adds a Additive White Gaussian Noise corresponding to the
% given snr value. The function finally returns the modulated signal.
function [modulatedSignal] = DQPSK_Modulation(signal,snr)
    signalLen = length(signal); %signal length
    difSignal = zeros(1,signalLen+1);
    firstBit = 1;
    difSignal(1) = firstBit;
    for i = 2:length(difSignal)
        difSignal(i) = ~xor(difSignal(i-1),signal(i-1));
    end
    difsignalLen = length(difSignal); 
    modulatedSignal = zeros(1,difsignalLen/2); %Initilizing modulatedSignal
    j = 1;
    % Performing QPSK modulation with gray labelling.
    % maping of the bits are as follows
    %[0,0]->(1+1i)/sqrt(2)
    %[0,1]->(-1+1i)/sqrt(2)
    %[1,1]->(-1-1i)/sqrt(2)
    %[1,0]->(1-1i)/sqrt(2)
    for i = 1:2:difsignalLen
        cur = difSignal(i:i+1);
        sym = [];
        if (isequal([0 0],cur))
            sym = (1+1i)/sqrt(2);
        elseif (isequal([0 1],cur))
            sym = (-1+1i)/sqrt(2);
        elseif (isequal([1 1],cur))
            sym = (-1-1i)/sqrt(2);
        elseif (isequal([1 0],cur))
            sym = (1-1i)/sqrt(2);
        end
        modulatedSignal(j) = sym;
        j = j+1;
    end
    modulatedSignal = myComplexAWGN(modulatedSignal,snr);% Addding AWGN 
end