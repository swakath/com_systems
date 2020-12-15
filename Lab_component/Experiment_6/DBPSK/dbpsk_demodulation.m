% This function is used to demodulate a dbpsk signal. The boundare condition
% is taken to be 0. The final demodulated signal is returned.
% Coded by S U Swakath. Last Updated: 12th Dec 2020

function [demodulatedSignal] = dbpsk_demodulation(signal)
    signalLen = length(signal);   
    demodulatedSignal = zeros(1,signalLen-1);
    for i = 1:signalLen
        if(signal(i)>0)
            signal(i) = 0;
        else
            signal(i) = 1;
        end
    end    
    
    for i = 1:signalLen-1
        demodulatedSignal(i) = ~xor(signal(i),signal(i+1));
    end        
end