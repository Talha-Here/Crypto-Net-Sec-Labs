disp("TALHA 114");
function result = find_mod(base, exponent, modulus)
    result = 1;
    base = mod(base, modulus);
    while exponent > 0
        if bitget(exponent, 1)
            result = mod(result * base, modulus);
        end
        base = mod(base^2, modulus);
        exponent = bitshift(exponent, -1);
    end
end

%{
m=[0 1 1 0]
m1 = bi2de(m,'left-msb',2)

%Source A
eA=7;
pA=5;
qA=3;
nA=pA*qA;
phi_A=(pA-1)*(qA-1);
[c,prikey1]=gcd(eA,phi_A);
prikey1 = mod(prikey1,phi_A)
 
%Source B 
eB=11;
pB=3;
qB=7;
nB=pB*qB;
phiB=(pB-1)*(qB-1);
[c,prikey2]=gcd(eB,phiB);
prikey2 = mod(prikey2,phiB)
 
%Source A
encryption = find_mod(m1, prikey1, nA);
finalencrypt = find_mod(encryption, eB, nA)

%Source B
decryption = find_mod(finalencrypt, prikey2, nB);
finaldecrypt = find_mod(decryption, eA, nB)
%}

base = 20;
power = 80;
mod = 95;
result = fastalgo(base, power, mod);
fprintf('%i power %i mod %i = %i\n',base,power,mod,result);


