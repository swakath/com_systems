%Program used to debug and experiment

message = "I Love India "; %input message/ transmitted message

codedMessage = encodeMessage(message);%encoding the message to morse code
modulatedSignal = bpsk_modulation(codedMessage,20); %bpsk modulation 
demodulatedSignal = bpsk_demodulation(modulatedSignal); %bpsk demodulation 
receivedMessage = decodeMessage(demodulatedSignal);%decoding received code

%printing the received message
fprintf("The receieved signal:%s\n",receivedMessage);