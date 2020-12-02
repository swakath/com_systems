function signalBits = symbolsToBits(signal, isGrayLabel)
    signalLen = length(signal);
    signalBits = zeros(1, signalLen*4);
    
    symbols = [3+3i, 1+3i, -1+3i, -3+3i;
               3+1i, 1+1i, -1+1i, -3+1i;
               3-1i, 1-1i, -1-1i, -3-1i;
               3-3i, 1-3i, -1-3i, -3-3i];
           
    bit_combos_gray = ["0 0 0 0", "0 0 0 1", "0 0 1 1", "0 0 1 0";
                       "0 1 0 0", "0 1 0 1", "0 1 1 1", "0 1 1 0";
                       "1 1 0 0", "1 1 0 1", "1 1 1 1", "1 1 1 0";
                       "1 0 0 0", "1 0 0 1", "1 0 1 1", "1 0 1 0"];
                   
    bit_combos_nogray = ["0 0 0 0", "0 0 0 1", "0 0 1 0", "0 0 1 1";
                         "0 1 0 0", "0 1 0 1", "0 1 1 0", "0 1 1 1";
                         "1 0 0 0", "1 0 0 1", "1 0 1 0", "1 0 1 1";
                         "1 1 0 0", "1 1 0 1", "1 1 1 0", "1 1 1 1"];

    if isGrayLabel == 1 % With gray labeling
        for i = 1:4:4*signalLen-3
            % Finding corresponding bit combinations
            indexMat = (symbols == signal(ceil(i/4)));
            signalBits(i:i+3) = str2num(bit_combos_gray(indexMat));
        end
    elseif isGrayLabel == 0 % Without gray labeling
        for i = 1:4:4*numel(signal)-3
            % Finding corresponding bit combinations
            indexMat = (symbols == signal(ceil(i/4)));
            signalBits(i:i+3) = str2num(bit_combos_nogray(indexMat));
        end
    else
        disp('Invalid Input for Gray Labeling. Must be only 0 or 1');
    end
end
