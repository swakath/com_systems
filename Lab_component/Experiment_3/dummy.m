a = [1 0 1 1];
b = [0 1 1 0];
c = a~=b;
err = sum(c);
disp(err)