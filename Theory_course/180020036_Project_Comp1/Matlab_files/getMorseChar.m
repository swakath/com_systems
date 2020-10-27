%This function takes a morse code as input and finds the corresponding
%character associated to the code from a dictionary and returns 
%the character. If a character is no found in the dictionary it returns '*'
% Coded by S U Swakath. Last Updated: 18th Oct 2020

function [char] = getMorseChar(code)
   %Morse code dictionary
   charMorseCode = {[1 0 1 1 1];[1 1 1 0 1 0 1 0 1];[1 1 1 0 1 0 1 1 1 0 1];[1 1 1 0 1 0 1];[1];[1 0 1 0 1 1 1 0 1];[1 1 1 0 1 1 1 0 1];[1 0 1 0 1 0 1];[1 0 1];[1 0 1 1 1 0 1 1 1 0 1 1 1];[1 1 1 0 1 0 1 1 1];[1 0 1 1 1 0 1 0 1];[1 1 1 0 1 1 1];[1 1 1 0 1];
       [1 1 1 0 1 1 1 0 1 1 1];[1 0 1 1 1 0 1 1 1 0 1];[1 1 1 0 1 1 1 0 1 0 1 1 1];[1 0 1 1 1 0 1];[1 0 1 0 1];[1 1 1];[1 0 1 0 1 1 1];[1 0 1 0 1 0 1 1 1];[1 0 1 1 1 0 1 1 1];[1 1 1 0 1 0 1 0 1 1 1];[1 1 1 0 1 0 1 1 1 0 1 1 1];[1 1 1 0 1 1 1 0 1 0 1];
       [1 0 1 1 1 0 1 1 1 0 1 1 1 0 1 1 1];[1 0 1 0 1 1 1 0 1 1 1 0 1 1 1];[1 0 1 0 1 0 1 1 1 0 1 1 1];[1 0 1 0 1 0 1 0 1 1 1];[1 0 1 0 1 0 1 0 1];[1 1 1 0 1 0 1 0 1 0 1];[1 1 1 0 1 1 1 0 1 0 1 0 1];[1 1 1 0 1 1 1 0 1 1 1 0 1 0 1];
       [1 1 1 0 1 1 1 0 1 1 1 0 1 1 1 0 1];[1 1 1 0 1 1 1 0 1 1 1 0 1 1 1 0 1 1 1];[0 0 0 0 0 0 0]};
   
   chars = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","1","2","3","4","5","6","7","8","9","0"," "];
   charsLen = size(chars,2);
   
   noCharFound = true; %to identify if a character is found for the code 
   
   %Finding the charater from the dictionary
   for i = 1:charsLen
        if isequal(charMorseCode{i},code)
            char = chars(i);
            noCharFound = false; %as the character is found.
        end
   end
   
   %If character not found then returning '*'
   if noCharFound     
        char  = "*";
   end
end