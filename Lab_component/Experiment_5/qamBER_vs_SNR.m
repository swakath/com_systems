% This code computes Bit Error Rate (BER) vs SNR plot for a QPSK modulation
% scheme with and without gray labelling in Additive White Gaussain Noise. 
% Plots the theoritical and simulation results
%% BER CALCULATION WITH GRAY LABELING
signalLen = 100000; %signal length

Itr = 100;%total number of samples to calculate each BER value

snr = 0:0.2:15; %SNR vector in dBW
snrLen = length(snr); % length of snr vector
%Vector to store bit error rate corresponding to each SNR value
BER_gray = zeros(1,snrLen);


for i = 1:snrLen
    curBER = 0;
    if (mod(i,5)==0)
        disp(i);
    end
    % Generating a random signal with binary bits (0 and 1)
    signal = randi([0,1],1,signalLen);
    for j = 1:Itr    
        % Generating QPSK symbols with gray labeling
        modulatedSignal = qam16Modulation(signal, snr(i),1);
               
        % Demodulation
        demodulatedSignal = qam16Demodulation(modulatedSignal,1);
        
        %error
        error = signal~=demodulatedSignal;
        curBER = curBER+sum(error);
    end
    BER_gray(i) = curBER;
end
% To get the fractional error
BER_gray = BER_gray/(signalLen*Itr);

% Plotting the BER vs. SNR graph
figure(3);
semilogy(snr, BER_gray, '-bo')
title('BER vs. SNR Plot (With Gray Labeling)');
xlabel('SNR (dBW)');
ylabel('BER');
grid on;

%% BER CALCULATION WITHOUT GRAY LABELING

% In this third section we calculate the BER without gray labeling
% We have an error resolution of 10^-6
% Please reduce the number of iterations to get lower run time.

signalLen = 10000; %signal length

Itr = 100; %total number of samples to calculate each BER value

snr = 0:0.2:15; %SNR vector in dBW
snrLen = length(snr);
%Vector to store bit error rate corresponding to each SNR value
BER_nogray = zeros(1,snrLen);

for i = 1:snrLen
    if (mod(i,5)==0)
        disp(i);
    end
    curBER = 0;
    % Generating a random signal with binary bits (0 and 1)
    signal = randi([0,1],1,signalLen);
    for j = 1:Itr
        % Generating QPSK symbols with gray labeling
        modulatedSignal = qam16Modulation(signal,snr(i),0);
        
        % Demodulation
        demodulatedSignal = qam16Demodulation(modulatedSignal,0);
        %error
        error = signal~=demodulatedSignal;
        curBER = curBER+sum(error);
    end
    BER_nogray(i) = curBER;
end

% To get the fractional error
BER_nogray = BER_nogray/(signalLen*Itr);

% Plotting the BER vs. SNR graph
figure(4);
semilogy(snr, BER_nogray, '-x')
title('BER vs. SNR Plot (Without Gray Labeling)');
xlabel('SNR (dBW)');
ylabel('BER');
grid on;

%% THEORETICAL GRAPH USING Q-FUNCTION

% In this fourth section we first compute a theoretical curves defining the
% error probability variation with SNR for a 16QAM communication system.
% We then plot the theoretical curves with our practical curves.

% We define signal to noise ratio as:
% SNR = Eb/No

% In our case of 16QAM communication system, we have
% Eb = 5/2
% Also, the textbook defines
% sigma = sqrt(No/2)        (sigma => standard deviation of noise)

% So, we get the relation between sigma and SNR as:
% sigma = sqrt(5/(4*SNR))

% As the calculation of bit error rate is difficult for 16QAM
% We calculate the symbol error rate as follows:
% P_s = 3*Q(sqrt(4*SNR/5)) - (9/4)*[Q(sqrt(4*SNR/5))]^2

% Symbol Error Rate (SER) is the same for both of the above cases
symErrThe = zeros(1, snrLen);
for i = 1:snrLen
    qvalue = qfunc(sqrt(4*(10^(snr(i)/10))/5));
    symErrThe(i) = 3*qvalue - (9/4)*qvalue*qvalue;
end

% -------- WITH GRAY LABELING ------------

% We get an approximation for the BER in this case:
% P_e = (3/4)*Q(sqrt(4*SNR/5))

BER_gray_the = zeros(1, snrLen);

% Calculation of theoretical error probability using Q-function
for i = 1:numel(snr_array)
    qvalue = qfunc(sqrt(4*(10^(snr(i)/10))/5));
    BER_gray_the(i) = (3/4)*qvalue;
end

% ----------------WITHOUT GRAY LABELING ----------------
% We were unable to derive an expression for BER in this case.
figure(6);
semilogy(snr, symErrThe, '-rx')
title('Symbol Error Rate vs. SNR Plot');
xlabel('SNR (dBW)');
ylabel('Symbol Error Rate');
grid on;


figure(7);
semilogy(snr, BER_gray_the, '-ro')
hold on
semilogy(snr, BER_gray, '-bx')
semilogy(snr, BER_nogray, '-gx')
hold off
title('BER vs. SNR Plot');
xlabel('SNR (dBW)');
ylabel('BER');
legend('Theoretical (Gray Labeling)', 'Practical BER (Gray Labeling)', 'Practical BER (No Gray Labeling)');
legend
grid on;