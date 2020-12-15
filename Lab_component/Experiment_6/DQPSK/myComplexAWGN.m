% Function to add Complex Additive Gaussian Noise to the given signal for
% the currespond snr value.
function noisy_signal = myComplexAWGN(signal, snr)
    % Generating a random number with normal distribution
    ReNoise = sqrt(1/(4*(10^(snr/10))))*randn(1,length(signal));
    ImNoise = sqrt(1/(4*(10^(snr/10))))*randn(1,length(signal));
    noise = ReNoise + 1i*ImNoise ;
    noisy_signal = signal + noise;
end