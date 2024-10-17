disp("TALHA 114");

q = 97;
alpha = 5;
xa = 36;
xb = 58;

% permitive root
%{
function result = prime_checker(p)
    % Checks If the number entered is a Prime Number or not
    if p < 1
        result = -1;
    elseif p > 1
        if p == 2
            result = 1;
        else
            for i = 2:p-1
                if mod(p, i) == 0
                    result = -1;
                    return;
                end
            end
            result = 1;
        end
    end
end

function result = primitive_check(g, p, L)
    % Checks If The Entered Number Is A Primitive Root Or Not
    for i = 1:p
        L = [L, mod(pow(g, i), p)];
    end
    for i = 1:p
        if sum(L == i) > 1
            L = [];
            result = -1;
            return;
        end
    end
    result = 1;
end

isprime = prime_checker(q);
fprintf('is prime: %d\n', isprime);
%}



function result = mod_pow(base, exponent, modulus)
% Calculate (base^exponent) mod modulus efficiently 
    result = 1; 
    while exponent > 0 
    if mod(exponent, 2) == 1 
        result = mod(result * base, modulus); 
    end 
    base = mod(base^2, modulus); 
    exponent = floor(exponent / 2); 
    end 
    end
function primitive_root = find_primitive_root() 
% Prompt the user to enter a prime number 
    q = input('Enter a prime number (q): '); 
    % Check if the entered number is prime 
    if ~isprime(q)
     	error('Input is not a prime number. Please enter a prime number.');
     end 
    % Prompt the user to enter n 
    n = input('Enter the value of n: '); 
    % Calculate alpha as 2^n 
    alpha = q-1; 
    n = alpha; 
    % Calculate b = (alpha^n) mod q 
    b = mod_pow(alpha, n, q); 
    fprintf('Primitive root modulo %d is: %d\n', q, b); 
    end 

isprime = find_primitive_root();

