% Function to add noise to the given signal
function noisy_signal = myAWGN(signal, snr)
    % Generating a random number with normal distribution
    noise = sqrt(1/((10^(snr/10))))*randn(1,length(signal));
    noisy_signal = signal + noise;
end