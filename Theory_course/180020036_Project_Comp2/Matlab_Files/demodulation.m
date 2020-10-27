%This function takes a receivedSignal and according to the energy of the
%received symbol it maps it to bit1 or bit0 and returns the final signal

function [finalSignal] = demodulation(receivedSignal)
    finalSignal = [];
    receivedSignalLen = size(receivedSignal,1);
    absValues = abs(receivedSignal);
        
    for i = 1:receivedSignalLen
        temp = absValues(i,:);
        if(temp(1)>temp(2))
            finalSignal = [finalSignal 1];
        else
            finalSignal = [finalSignal 0];
        end
    end
end