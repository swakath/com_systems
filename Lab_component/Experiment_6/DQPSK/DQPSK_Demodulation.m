% This function performs DQPSK demodulation (using gray labelling) on the 
% given signal. The function demodulates using distance rule.
function [demodulatedSignal] = DQPSK_Demodulation(signal)
    signalLen = length(signal); % Signal length
    difSignal = zeros(1,2*signalLen); % Inilizing demodulatedSignal
% Vector containing symbols used for QPSK modulation(using gray labelling) 
    sym =[1+1i,-1+1i,-1-1i,1-1i]/sqrt(2);
    %Finding the most likely symbol transmistted using distance rule and
    %mapping the symbol to its corresponding bits.
    %(1+1i)/sqrt(2)->[0,0]
    %(-1+1i)/sqrt(2)->[0,1]
    %(-1-1i)/sqrt(2)->[1,1]
    %(1-1i)/sqrt(2)->[1,0]
    for i = 1:signalLen
        bits = [];
        cur = signal(i);
        dist = abs(sym-cur);
        [val,ind] = min(dist);
        if (ind == 1)
            bits = [0 0];
        elseif (ind == 2)
            bits = [0 1];
        elseif (ind == 3)
            bits = [1 1];
        elseif (ind == 4)
            bits = [1 0];
        end
        j = i*2;
        difSignal(j-1:j) = bits;        
    end
    demodulatedSignal = zeros(1,(2*signalLen)-1);
    for i = 1:(2*signalLen)-1
        demodulatedSignal(i) = ~xor(difSignal(i),difSignal(i+1));
    end
end