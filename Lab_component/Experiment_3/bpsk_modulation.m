%This function take a binary signal and Signal to Noise Ratio(snr) as input
%It maps bit 1=> -1 and bit 0=>1 and adds awgn to the modulates signal and
%returns the final modulated signal+noise.
% Coded by S U Swakath. Last Updated: 18th Oct 2020

function [modulatedSignal] = bpsk_modulation(signal,snr)
    modulatedSiganl = -2*signal + 1; %mapping bits 1 => -1 and bits 0 => 1
    modulatedSignal = myAWGN(modulatedSiganl,snr); % adding noise
end