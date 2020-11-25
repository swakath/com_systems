clc;clear all;close all;
len = 9;
x = randi([0 1],1,len);
if (mod(len,2) == 1)
    x = [x 0];
end
y = QPSK_grayModulation(x,1);
res = QPSK_grayDemodulation(y);
disp(x);
disp(y);
disp(res);
disp(res == x)