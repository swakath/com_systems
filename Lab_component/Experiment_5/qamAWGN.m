%Function to add complex AWGN over the given signal.
function noisySignal = qamAWGN(signal, snr)
    % Generating a random complex number with normal distribution
    signalLen = length(signal);
    reNoise = sqrt(5/(4*(10^(snr/10))))*randn(1,signalLen);
    imNoise = sqrt(5/(4*(10^(snr/10))))*randn(1,signalLen);
    noise = reNoise + 1i*imNoise;
    
    noisySignal = signal + noise;
end
