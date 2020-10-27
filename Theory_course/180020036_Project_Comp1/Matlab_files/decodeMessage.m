%This function take a morse code encoded message and returns the decoded 
%message in the form of a string.
% Coded by S U Swakath. Last Updated: 19th Oct 2020

function [decodedMessage] = decodeMessage(encodedMessage)
encodedMessageLen = size(encodedMessage,2);
decodedMessage = "";
j = 1;
stack = [];
prevSpace = false;

while(j<=encodedMessageLen)
    stack = [stack encodedMessage(j)];
    stackLen = size(stack,2);
    if stackLen > 3
        if isequal(stack(stackLen-2:stackLen),[0 0 0])
            char = getMorseChar(stack(1:stackLen-3));
            decodedMessage = append(decodedMessage,char);
            stack = [];
            prevSpace = false;
        end
    elseif stackLen == 3
            if isequal(stack,[0 0 0])
                char = " ";
                decodedMessage = append(decodedMessage,char);
                stack = [];
                j = j+1;
                if(prevSpace)
                    j = j+3;
                end
                prevSpace = true;
            end
    end
    
    if j == encodedMessageLen
        if (~isequal(stack,[]))
            char = getMorseChar(stack);
            decodedMessage = append(decodedMessage,char);
            stack = [];
        end
    end
    j = j+1;
end
end