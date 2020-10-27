%This fuction takes a modulatedSignal (represented x) and returns received 
%signal (represented y), where y = h*x + n , h is gaussian random variable
%with zero mean and unit variance, n is gaussian noise according to the
%given signal to noise ratio.
function [receivedSignal] = channel(modulatedSignal,snr)
    receivedSignal = [];
    modulatedSignalLen = size(modulatedSignal,1);

    h_c1 = rand(modulatedSignalLen,1);
    h_c2 = rand(modulatedSignalLen,1);
    
    %finding (h*x)
    receivedSignal = modulatedSignal;
    receivedSignal(:,1) = h_c1.*receivedSignal(:,1);
    receivedSignal(:,2) = h_c2.*receivedSignal(:,2);
    
    %adding awgn
    receivedSignal = awgn(receivedSignal,snr,'measured');

end