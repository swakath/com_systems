%This function takes a signal and value "a" as inputs and maps 
%bit 0 => [0 a] and bit 1 => [a 0] and returns the modulatedSignal
function [modulatedSignal] = modulation(signal,a)
    signalLen = size(signal,2);
    modulatedSignal = [];
    for i = 1:signalLen
        if(signal(i) == 0)
            modulatedSignal = [modulatedSignal ; [0 a]];
        else
            modulatedSignal = [modulatedSignal ; [a 0]];
        end
    end
end