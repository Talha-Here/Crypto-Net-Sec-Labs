disp("TALHA 114")
% Additive Cipher
function encrypted_text = additive_cipher(text, key)
    encrypted_text = char(mod(double(text) - 97 + key, 26) + 97);
end

function decrypted_text = inverse_additive_cipher(text, key)
    decrypted_text = char(mod(double(text) - 97 - key, 26) + 97);
end

% Hill Cipher
function encrypted_text = hill_cipher(text, key_matrix)
    block_size = size(key_matrix, 1);
    text = pad_text(text, block_size);
    encrypted_text = '';
    
    for i = 1:block_size:length(text)
        block = double(text(i:i+block_size-1)) - 97;
        encrypted_block = mod(key_matrix * block', 26);
        encrypted_text = [encrypted_text, char(encrypted_block' + 97)];
    end
end

function decrypted_text = inverse_hill_cipher(text, key_matrix)
    inv_key_matrix = inv_mod(key_matrix, 26);
    block_size = size(key_matrix, 1);
    text = pad_text(text, block_size);
    decrypted_text = '';
    
    for i = 1:block_size:length(text)
        block = double(text(i:i+block_size-1)) - 97;
        decrypted_block = mod(inv_key_matrix * block', 26);
        decrypted_text = [decrypted_text, char(decrypted_block' + 97)];
    end
end

function padded_text = pad_text(text, block_size)
    pad_len = mod(-length(text), block_size);
    padded_text = [text, repmat('x', 1, pad_len)];
end

function inv_matrix = inv_mod(matrix, mod_base)
    det = mod(det(matrix), mod_base);
    inv_det = mod_inv(det, mod_base);
    adj_matrix = mod(round(det * inv(matrix)), mod_base);
    inv_matrix = mod(adj_matrix * inv_det, mod_base);
end

function x = mod_inv(a, m)
    [g, x, ~] = gcd(a, m);
    if g ~= 1
        error('Modular inverse does not exist');
    else
        x = mod(x, m);
    end
end

% Rail Fence Cipher
function encrypted_text = rail_fence_cipher(text, key)
    rail = cell(1, key);
    dir_down = false;
    row = 1;
    for i = 1:length(text)
        rail{row} = [rail{row}, text(i)];
        if row == 1 || row == key
            dir_down = ~dir_down;
        end
        row = row + (dir_down * 2 - 1);
    end
    encrypted_text = [rail{:}];
end

function decrypted_text = inverse_rail_fence_cipher(cipher, key)
    rail = cell(1, key);
    dir_down = false;
    row = 1;
    mark = blanks(length(cipher));
    for i = 1:length(cipher)
        mark(i) = '*';
        if row == 1 || row == key
            dir_down = ~dir_down;
        end
        row = row + (dir_down * 2 - 1);
    end
    
    pos = 1;
    for i = 1:key
        for j = 1:length(cipher)
            if mark(j) == '*'
                mark(j) = cipher(pos);
                pos = pos + 1;
            end
        end
    end
    
    dir_down = false;
    row = 1;
    decrypted_text = blanks(length(cipher));
    for i = 1:length(cipher)
        decrypted_text(i) = mark(i);
        if row == 1 || row == key
            dir_down = ~dir_down;
        end
        row = row + (dir_down * 2 - 1);
    end
end

% Keyed Transposition Cipher
function encrypted_text = keyed_transposition_cipher(text, key)
    n = length(key);
    text = pad_text(text, n);
    num_cols = length(text) / n;
    reshaped_text = reshape(text, num_cols, n)';
    [~, order] = sort(key);
    encrypted_text = reshaped_text(order, :)';
    encrypted_text = encrypted_text(:)';
end

function decrypted_text = inverse_keyed_transposition_cipher(cipher, key)
    n = length(key);
    num_cols = length(cipher) / n;
    reshaped_text = reshape(cipher, n, num_cols)';
    [~, order] = sort(key);
    decrypted_text = reshaped_text(:, order)';
    decrypted_text = decrypted_text(:)';
end

% Feistel Cipher
function ciphertext = feistel_cipher(plaintext, key, rounds)
    len = length(plaintext);
    if mod(len, 2) == 1
        plaintext = [plaintext 'x']; % pad if odd length
        len = len + 1;
    end
    left = plaintext(1:len/2);
    right = plaintext(len/2 + 1:end);

    additive_key = mod(key, 26);
    hill_key = [2 3; 1 4];
    
    for round = 1:rounds
        % Apply ciphers to the right part
        temp_right = additive_cipher(right, additive_key);
        temp_right = rail_fence_cipher(temp_right, 2);
        temp_right = hill_cipher(temp_right, hill_key);
        temp_right = keyed_transposition_cipher(temp_right, 'key');
        
        % XOR and Swap
        new_right = xor_text(left, temp_right);
        left = right;
        right = new_right;
    end

    ciphertext = [left right];
end

function plaintext = feistel_decipher(ciphertext, key, rounds)
    len = length(ciphertext);
    left = ciphertext(1:len/2);
    right = ciphertext(len/2 + 1:end);

    additive_key = mod(key, 26);
    hill_key = [2 3; 1 4];
    
    for round = 1:rounds
        % XOR and Swap
        new_left = xor_text(left, right);
        right = left;
        left = new_left;
        
        % Inverse ciphers to the left part
        temp_left = inverse_keyed_transposition_cipher(left, 'key');
        temp_left = inverse_hill_cipher(temp_left, hill_key);
        temp_left = inverse_rail_fence_cipher(temp_left, 2);
        left = inverse_additive_cipher(temp_left, additive_key);
    end

    plaintext = [left right];
end

% XOR function for text
function result = xor_text(text1, text2)
    text1 = pad_text(text1, length(text2));
    text2 = pad_text(text2, length(text1));
    result = char(bitxor(uint8(text1), uint8(text2)) + 97);
end

% Input
plaintext = 'talha';
key = 114;

% Encrypt
ciphertext = feistel_cipher(plaintext, key, 2);
fprintf('Ciphertext: %s\n', ciphertext);

% Decrypt
deciphered_text = feistel_decipher(ciphertext, key, 2);
fprintf('Deciphered Text: %s\n', deciphered_text);
