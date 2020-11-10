function [dftx] = mydft(x,N)
    xlen = length(x);     
    if N>=xlen
        x = [x zeros(1,(N-xlen))];
    end
    k = 0:N-1;
    dftx = zeros(1,N);
    for j = 1:N
        dftx = dftx + x(j)*exp(((-1i)*2*pi*k*(j-1))/N);
    end
end