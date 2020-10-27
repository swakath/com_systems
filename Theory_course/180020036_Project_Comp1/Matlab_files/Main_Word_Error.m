%This program finds the word error rate for each value of snr and plots a
%graphs between word error rate and snr.
% Coded by S U Swakath. Last Updated: 19th Oct 2020

%words array (below) containa 50 words
%Reduce the words array length for faster computation
%50 words will take 20+min for computation.
words = {'symmachy', 'sargus', 'tanzim', 'flymaker', 'testones', 'wrey', 'subsenses', 'apomorphy', 'fulvalene', 'beardmoss', 'commutant', 'ipus', 'astony', 'horkey', 'amarelle', 'erectility', 'chideress', 'dynode', 'stapedius', 'Mawworms', 'renitence', 'pallasites', 'trindle', 'crevisse', 'pentagraph', 'peekapoo', 'creyme', 'whangee', 'chondr', 'poison', 'borism', 'teascrub', 'fighting', 'sixteenmo', 'lightrays', 'finific', 'plugrod', 'atoner', 'dactylics', 'HGHarrison', 'zonohedron', 'firecrests', 'chiromys', 'wolving', 'smicker', 'minth', 'gymgoer', 'eschel', 'horseload', 'oides'};
wordsLen = size(words,2);

snr = 1:0.1:25; %values of snr for the plot
snrLen = size(snr,2); %lenght of snr vector
finalerr = zeros(1,snrLen); %final word error rate for each snr
worderr = []; % to save error rate for each word from the words array
curerr = 0; %to store the number of non matching signals 

%Finding the word error rate for each snr
for k =1:wordsLen
    curWord = words{k};
    upCurWord = upper(curWord);
    fprintf("Working on %d %s..\n",k,curWord);
    encodedMessage = encodeMessage(curWord);
    for i= 1:0.1:25
        curerr = 0;       
        for j = 1:1000 %1000 samples are taken to determine the error
            modulatedSignal = bpsk_modulation(encodedMessage,i);
            receievedCodedMessage = bpsk_demodulation(modulatedSignal);
            receievedMessage = decodeMessage(receievedCodedMessage);
            if(receievedMessage~=upCurWord)
                curerr = curerr + 1;
            end
        end
        curerr = curerr/1000;
        worderr = [worderr curerr];
    end
    finalerr = finalerr + worderr;
    worderr = [];
end

finalerr = finalerr/wordsLen;

%plotting the graph between snr and computed word error rates
plot(snr,finalerr)
title("Word error rate vs SNR")
xlabel("SNR");
ylabel("Error")