disp("Talha 114");
%{
function result = mod_pow(base, exponent, modulus) 
    result = 1;
    while exponent > 0
        if mod(exponent, 2) == 1
            result = mod(result * base, modulus);
        end
        base = mod(base^2, modulus);
        exponent = floor(exponent / 2);
    end
 
end

q = input('Enter a prime number (q): '); 
while ~isprime(q)
    q = input('Not a prime no, Enter again: ');
end
fprintf('\nFinding all primitive roots modulo %d\n', q);
all_primitive_roots = [];
for alpha = 2:q-1    
    is_primitive = true;
    primitive_root = [];
    for n = 1:q-1
        result = mod_pow(alpha, n - 1, q);
        if ismember(result, primitive_root)
            is_primitive = false;
            break;
        else
            primitive_root = [primitive_root, result];
        end
    end
    if is_primitive
        all_primitive_roots = [all_primitive_roots, alpha];
    end
end
fprintf('\nAll primitive roots modulo %d are: %s\n', q, num2str(all_primitive_roots));
%}

q = 83;
alpha = 5;
X_A = 6; 
X_B = 10; 
  
Y_A = mod(alpha^X_A, q); Y_B = mod(alpha^X_B, q);
 
 
disp(['User A Public Key (Y_A): ', num2str(Y_A)]); 
disp(['User B Public Key (Y_B): ', num2str(Y_B)]);
K_session_A = mod(Y_B^X_A, q); 
K_session_B = mod(Y_A^X_B, q);
 
 
disp(['User A Session Key (K_session_A): ', num2str(K_session_A)]); 
disp(['User B Session Key (K_session_B): ', num2str(K_session_B)]);
 
if K_session_A == K_session_B
disp('Session keys match. Key exchange successful.'); 
else
disp('Session keys do not match. Key exchange failed.'); 
end


