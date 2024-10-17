
disp("TALHA 114");
x_str = "0110";
e = 7;
p = 5;
q = 3;
x = bin2dec(x_str);

n=p*q;
phi=(p-1)*(q-1);

[g, inv] = gcd(e,phi)
d = mod(inv,phi)


%Encrypt
disp('cipher: ');
y_pow = power(x,e)
y = mod(y_pow,n)
%Decrypt
disp('decrypt: ');
x_pow = power(y,d)
x_decrypt = mod(x_pow,n)
