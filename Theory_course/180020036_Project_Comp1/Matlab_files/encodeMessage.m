%This function take a message in form of a string and returns the
%corresponding Morse code.
% Coded by S U Swakath. Last Update: 18th Oct 2020

function [encodedMessage] = encodeMessage(message)
    encodedMessage = []; %final encodedMessage
    charCode = []; %stores the morse code of each character
    letterGap = [0 0 0]; %Morse code for gap between each letter
    capsMessage = upper(message); %converting message to uppercase.
    messageLen = strlength(capsMessage); 
    prevSpace = false; %to identify was the previous character a space. 
    
    for i = 1:messageLen
        %Extracting each character and finding it's morse code
        char = extractBetween(capsMessage,i,i); 
        charCode = getMorseCode(char);
        
        %Adding the character code into final encodedMessage
        if((char ~= " ")&&(i~=1)&&(~prevSpace)) 
            encodedMessage = [encodedMessage letterGap];
        end
        encodedMessage = [encodedMessage charCode];
        
        if (char == " ")
            prevSpace = true;
        else
            prevSpace = false;
        end
        charCode = [];
    end
end