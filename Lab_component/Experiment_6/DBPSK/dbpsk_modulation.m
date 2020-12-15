%This function take a binary signal and Signal to Noise Ratio(snr) as input
%Performs Differential BPSK over the given signal.
%It maps bit 1=> -1 and bit 0=>1 and adds awgn to the modulates signal and
%returns the final modulated signal+noise.
% Coded by S U Swakath. Last Updated: 12th Dec 2020

function [modulatedSignal] = dbpsk_modulation(signal,snr)
    firstBit = 1;
    modulatedSignal = zeros(1,length(signal)+1);
    modulatedSignal(1) = firstBit;
    for i = 2:length(modulatedSignal)
        modulatedSignal(i) = ~xor(modulatedSignal(i-1),signal(i-1));
    end
    modulatedSignal = -2*modulatedSignal + 1; %mapping bits 1 => -1 and bits 0 => 1
    modulatedSignal = myAWGN(modulatedSignal,snr); % adding noise
end