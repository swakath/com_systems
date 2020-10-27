%This program finds the letter error rate for each value of snr and plots a
%graphs between letter error rate and snr.
% Coded by S U Swakath. Last Updated: 19th Oct 2020

%chars array (below) contain all english letters and numbers from 0 to 9
chars = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","1","2","3","4","5","6","7","8","9","0"];

charsLen = size(chars,2); % stores the length of the chars array

snr = 1:0.1:25; %different values of snr for plotting the graphs
snrLen = size(snr,2); %length of snr array
finalerr = zeros(1,snrLen);%final letter error rate for each snr
charerr =[]; %to store error rate of each character for different snr

%Finding the letter error
for k = 1:charsLen
    char = chars(k);
    fprintf("Working on character %s ...\n",char);
    encodedMessage = encodeMessage(char);
    for i= 1:0.1:25
        leterr = 0;       
    
        for j = 1:1000  %1000 samples are take to determine the error
            modulatedSignal = bpsk_modulation(encodedMessage,i);
            receievedCodedMessage = bpsk_demodulation(modulatedSignal);
            receievedMessage = decodeMessage(receievedCodedMessage);
            if(receievedMessage~=char)
                leterr = leterr + 1;
            end
        end
        leterr = leterr/1000;
        charerr = [charerr leterr];
    end
    finalerr = finalerr + charerr;
    charerr = [];
end
finalerr = finalerr/charsLen;
disp("Computation done now plotting");

%Plotting the graph between computed letter error rates vs snr
figure(1)
plot(snr,finalerr);
title("Letter Error Rate vs SNR");
xlabel("SNR");
ylabel("Error rate")

figure(2)
semilogy(snr,finalerr);
title("Letter Error Rate vs SNR");
xlabel("SNR");
ylabel("Error rate")