
disp("TALHA 114");

function [ K1, K2 ] = keyGenerator( key, P8, P10 )
    key = key(P10);
    
    j=1;
    for i = 1:length(key)
        if (i<=5)
            key_left(i)= key(i);
        else
            key_right(j)= key(i);
            j = j + 1;
        end
    end
    
    key_left_left_shifted = circshift( key_left, [1 , -1] );
    key_right_left_shifted = circshift( key_right,[ 1 , -1] );
    
    merged_key_shifted = strcat( key_left_left_shifted, key_right_left_shifted );
    K1 = merged_key_shifted(P8);
    
    key2_left_left_shifted = circshift( key_left_left_shifted, [2, -2]);
    key2_right_left_shifted = circshift( key_right_left_shifted, [2, -2]);
    
    merged_key2_shifted = strcat( key2_left_left_shifted, key2_right_left_shifted );
    K2 = merged_key2_shifted(P8); 
end

function [ plaintext_right,D ] = fk( plaintext , k)
    S0 = [1 0 3 2; 
          3 2 1 0; 
          0 2 1 3; 
          3 1 3 2];
    S1 = [0 1 2 3; 
          2 0 1 3; 
          3 0 1 0; 
          2 1 0 3];
    P4 = [2 4 3 1];
    EP = [4 1 2 3 2 3 4 1];
    plaintext_left = plaintext(1:4);
    plaintext_right = plaintext(5:8);
    plaintext_right_EP = plaintext_right(EP);
    %xor
    for i = 1:length(plaintext_right_EP)
        C(i) = xor(str2double(plaintext_right_EP(i)),str2double(k(i)));
    end
    %for left 4 bits
    C_left = C(1:4);
    row1 = [C_left(1) , C_left(4)];
    row1_dec = bi2de(row1,'left-msb');
    
    col1 = [C_left(2) , C_left(3)];
    col1_dec = bi2de(col1,'left-msb');
    S0_two_bits = de2bi(S0(row1_dec+1,col1_dec+1),'left-msb');
 
    if ((numel(S0_two_bits)) < 2)
        S0_two_bits_str = char('0' + S0_two_bits);
        padding = repmat('0', 1, 2 - numel(S0_two_bits_str));
        S0_two_bits_str = [padding, S0_two_bits_str]
    else
        e = [S0_two_bits(1) S0_two_bits(2)];
        S0_two_bits_str = strrep(num2str(e),' ','');
    end
    
    %for right 4 bits
    C_right = C(5:8);
    row2 = [C_right(1) , C_right(4)];
    row2_dec = bi2de(row2,'left-msb');
    
    col2 = [C_right(2) , C_right(3)];
    col2_dec = bi2de(col2,'left-msb');
    
    S1_two_bits = de2bi(S1(row2_dec+1,col2_dec+1),'left-msb');
  
    if (numel(S1_two_bits) < 2)
        S1_two_bits_str = char('0' + S1_two_bits);
        padding = repmat('0', 1, 2 - numel(S1_two_bits_str));
        S1_two_bits_str = [padding, S1_two_bits_str];
    else
        d = [S1_two_bits(1) S1_two_bits(2)];
        S1_two_bits_str = strrep(num2str(d),' ','');
    end
 
    S0_S1_combined = strcat(S0_two_bits_str,S1_two_bits_str);
    S0_S1_combined_P4 = S0_S1_combined(P4);
  
    %xor
    for i = 1:length(S0_S1_combined_P4)
        D(i) = xor(str2double(plaintext_left(i)),str2double(S0_S1_combined_P4(i)));
    end
    D = strrep(num2str(D),' ','');
end


plaintext = '10110111';
key = '1100110010';
IP = [2 6 3 1 4 8 5 7];
IP_inverse = [4 1 3 5 7 2 8 6];
P8 = [6 3 7 4 8 5 10 9];
P10 = [3 5 2 7 4 10 1 9 8 6];
fprintf('S-DES Algorithm:\n');
[k1, k2] = keyGenerator(key, P8, P10);
plaintext_IP = plaintext(IP);
[plaintext_right, xor] = fk(plaintext_IP, k1);
SW = strcat(plaintext_right,xor);
[plaintext_right, xor] = fk(SW, k2);
pt_right_xor = strcat(xor,plaintext_right);
cipher_text = pt_right_xor(IP_inverse);
fprintf('Plain Text given: %s\n',plaintext);
fprintf('Key given: %s\n',key);
fprintf('Cipher Text generated: %s\n',cipher_text);

