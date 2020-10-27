%This function takes a character as input and finds the corresponding morse 
%code from a dictionary and returns the morse code.
% Coded by S U Swakath. Last Updated: 19th Oct 2020

function [code] = getMorseCode(val)

%Morse code dictionary
   charMorseCode = {[1 0 1 1 1];[1 1 1 0 1 0 1 0 1];[1 1 1 0 1 0 1 1 1 0 1];[1 1 1 0 1 0 1];[1];[1 0 1 0 1 1 1 0 1];[1 1 1 0 1 1 1 0 1];[1 0 1 0 1 0 1];[1 0 1];[1 0 1 1 1 0 1 1 1 0 1 1 1];[1 1 1 0 1 0 1 1 1];[1 0 1 1 1 0 1 0 1];[1 1 1 0 1 1 1];[1 1 1 0 1];
       [1 1 1 0 1 1 1 0 1 1 1];[1 0 1 1 1 0 1 1 1 0 1];[1 1 1 0 1 1 1 0 1 0 1 1 1];[1 0 1 1 1 0 1];[1 0 1 0 1];[1 1 1];[1 0 1 0 1 1 1];[1 0 1 0 1 0 1 1 1];[1 0 1 1 1 0 1 1 1];[1 1 1 0 1 0 1 0 1 1 1];[1 1 1 0 1 0 1 1 1 0 1 1 1];[1 1 1 0 1 1 1 0 1 0 1];
       [1 0 1 1 1 0 1 1 1 0 1 1 1 0 1 1 1];[1 0 1 0 1 1 1 0 1 1 1 0 1 1 1];[1 0 1 0 1 0 1 1 1 0 1 1 1];[1 0 1 0 1 0 1 0 1 1 1];[1 0 1 0 1 0 1 0 1];[1 1 1 0 1 0 1 0 1 0 1];[1 1 1 0 1 1 1 0 1 0 1 0 1];[1 1 1 0 1 1 1 0 1 1 1 0 1 0 1];
       [1 1 1 0 1 1 1 0 1 1 1 0 1 1 1 0 1];[1 1 1 0 1 1 1 0 1 1 1 0 1 1 1 0 1 1 1];[0 0 0 0 0 0 0]};
   
   chars = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","1","2","3","4","5","6","7","8","9","0"," "];
   charsLen = size(chars,2);
   
%Finding the code from the dictionary
   for i = 1:charsLen
       if isequal(val,chars(i))
            code = charMorseCode{i};
            break;
       end
   end
   
end