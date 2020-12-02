%This Function performs 16QAM modulation with/without gray labeling
%over the given signal and adds an AWGN corresponding to the snr
function modulatedSignal = qam16Modulation(signal, snr, isGrayLabel)
    signalLen = length(signal);
    modulatedSignal = zeros(1, signalLen/4);
    symbols = [3+3i, 1+3i, -1+3i, -3+3i;
               3+1i, 1+1i, -1+1i, -3+1i;
               3-1i, 1-1i, -1-1i, -3-1i;
               3-3i, 1-3i, -1-3i, -3-3i];

% Gray Labeling mapping of bits is done as follows:

%                         16QAM With Gray Labelling
%                                    |
%                   *          *    3|     *          *
%                  0010       0011   |    0001       0000
%                                    |
%                                    |
%                   *          *    1|     *          *
%                  0110       0111   |    0101       0100   
%           _________________________|___________________________
%                  -3         -1     |     1          3 
%                                    |
%                   *          *   -1|     *          *
%                  1110       1111   |    1101       1100
%                                    | 
%                                    |
%                   *          *   -3|     *          *
%                  1010       1011   |    1001       1000
%                                    |       
    bit_combos_gray = ["0 0 0 0", "0 0 0 1", "0 0 1 1", "0 0 1 0";
                       "0 1 0 0", "0 1 0 1", "0 1 1 1", "0 1 1 0";
                       "1 1 0 0", "1 1 0 1", "1 1 1 1", "1 1 1 0";
                       "1 0 0 0", "1 0 0 1", "1 0 1 1", "1 0 1 0"];

% Without Gray Labeling mapping of bits is done as follows:

%                         16QAM Without Gray Labelling
%                                    |
%                   *          *    3|     *          *
%                  0011       0010   |    0001       0000
%                                    |
%                                    |
%                   *          *    1|     *          *
%                  0111       0110   |    0101       0100   
%           _________________________|___________________________
%                  -3         -1     |     1          3 
%                                    |
%                   *          *   -1|     *          *
%                  1011       1010   |    1001       1000
%                                    | 
%                                    |
%                   *          *   -3|     *          *
%                  1111       1110   |    1101       1100
%                                    |
                  
    bit_combos_nogray = ["0 0 0 0", "0 0 0 1", "0 0 1 0", "0 0 1 1";
                         "0 1 0 0", "0 1 0 1", "0 1 1 0", "0 1 1 1";
                         "1 0 0 0", "1 0 0 1", "1 0 1 0", "1 0 1 1";
                         "1 1 0 0", "1 1 0 1", "1 1 1 0", "1 1 1 1"];

    if isGrayLabel == 1 % With Gray Labeling
        for i = 1:4:signalLen-3
            % Finding the symbols corresponding to 4 bits at a time
            bits = strjoin(string(signal(i:i+3)));
            indexMat = contains(bit_combos_gray, bits);
            modulatedSignal(ceil(i/4)) = symbols(indexMat);
        end
    elseif isGrayLabel == 0 % Without Gray Labeling
        for i = 1:4:signalLen-3
            % Finding the symbols corresponding to 4 bits at a time
            bits = strjoin(string(signal(i:i+3)));
            indexMat = contains(bit_combos_nogray, bits);
            modulatedSignal(ceil(i/4)) = symbols(indexMat);
        end
    else
        disp('Invalid Input for Gray Labeling. Must be only 0 or 1');
    end
    modulatedSignal = qamAWGN(modulatedSignal,snr);
end