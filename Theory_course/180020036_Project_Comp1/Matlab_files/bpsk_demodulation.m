% This function is used to demodulate a bpsk signal. The boundare condition
% is taken to be 0. The function takes a signal and maps all the positive
% values to bit 0 and all the negative values to bit 1.
% The final demodulated signal is returned.
% Coded by S U Swakath. Last Updated: 18th Oct 2020

function [demodulatedSignal] = bpsk_demodulation(signal)
    signalLen = size(signal,2);   
    for i = 1:signalLen
        if(signal(i)>0)
            signal(i) = 0;
        else
            signal(i) = 1;
        end
    end    
    demodulatedSignal = signal;
end