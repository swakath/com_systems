% Function to performs demodulation using decision boundaries
function demodulatedSignal = qam16Demodulation(signal,isGrayLabel)
    signalLen = length(signal);
    demodulatedSignal = zeros(1, signalLen);
    symbols = [3+3i, 1+3i, -1+3i, -3+3i;
               3+1i, 1+1i, -1+1i, -3+1i;
               3-1i, 1-1i, -1-1i, -3-1i;
               3-3i, 1-3i, -1-3i, -3-3i];
    
    for i = 1:signalLen
        % To get distance of signal point from each of the symbols
        distance = abs(symbols - signal(i));
        
        % To get the index of the minimum distance
        [~, index] = min(distance, [], 'all', 'linear');
        
        % The closest (distance wise) symbol is chosen
        demodulatedSignal(i) = symbols(index);
    end
    demodulatedSignal = symbolsToBits(demodulatedSignal,isGrayLabel);
end