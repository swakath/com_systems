x = [1+1i,-1+1i,-1-1i,1-1i]/sqrt(2);
y = -0.2329 - 0.2357*1i;
z = abs(x-y);
[c,ind] = min(z);
disp(z);
disp(ind);