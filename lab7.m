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
    text = pad(text, block_size);
    encrypted_text = '';
    
    for i = 1:block_size:length(text)
        block = double(text(i:i+block_size-1)) - 97;
        encrypted_block = mod(block * key_matrix, 26);
        encrypted_text = [encrypted_text, char(encrypted_block + 97)];
    end
end

function decrypted_text = inverse_hill_cipher(text, key_matrix)
    inv_key_matrix = inv_mod(key_matrix, 26);
    block_size = size(key_matrix, 1);
    text = pad(text, block_size);
    decrypted_text = '';
    
    for i = 1:block_size:length(text)
        block = double(text(i:i+block_size-1)) - 97;
        decrypted_block = mod(block * inv_key_matrix, 26);
        decrypted_text = [decrypted_text, char(decrypted_block + 97)];
    end
end

function padded_text = pad(text, block_size)
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
    rail = blanks(length(text));
    dir_down = false;
    row = 1;
    index = 1;
    for i = 1:length(text)
        if row == 1 || row == key
            dir_down = ~dir_down;
        end
        rail(index) = text(i);
        index = index + 1;
        if dir_down
            row = row + 1;
        else
            row = row - 1;
        end
    end
    encrypted_text = rail;
end

function decrypted_text = inverse_rail_fence_cipher(cipher, key)
    rail = blanks(length(cipher));
    dir_down = false;
    row = 1;
    index = 1;
    for i = 1:length(cipher)
        if row == 1 || row == key
            dir_down = ~dir_down;
        end
        rail(index) = '*';
        index = index + 1;
        if dir_down
            row = row + 1;
        else
            row = row - 1;
        end
    end
    result = blanks(length(cipher));
    k = 1;
    for i = 1:length(rail)
        if rail(i) == '*'
            rail(i) = cipher(k);
            k = k + 1;
        end
    end
    row = 1;
    dir_down = false;
    for i = 1:length(rail)
        if row == 1 || row == key
            dir_down = ~dir_down;
        end
        result(i) = rail(i);
        if dir_down
            row = row + 1;
        else
            row = row - 1;
        end
    end
    decrypted_text = result;
end

% Keyed Transposition Cipher
function encrypted_text = keyed_transposition_cipher(text, key)
    n = length(key);
    text = pad(text, n);
    num_cols = length(text) / n;
    reshaped_text = reshape(text, n, num_cols)';
    [~, order] = sort(key);
    encrypted_text = reshaped_text(:, order)';
    encrypted_text = encrypted_text(:)';
end

function decrypted_text = inverse_keyed_transposition_cipher(cipher, key)
    n = length(key);
    cipher = pad(cipher, n);
    num_cols = length(cipher) / n;
    reshaped_text = reshape(cipher, num_cols, n)';
    [~, order] = sort(key);
    decrypted_text = reshaped_text(order, :)';
    decrypted_text = decrypted_text(:)';
    decrypted_text = decrypted_text(1:end);
end

% Feistel Cipher
function ciphertext = feistel_cipher(plaintext, key, rounds)
    len = length(plaintext);
    left = plaintext(1:floor(len/2));
    right = plaintext(floor(len/2)+1:end);

    additive_key = key;
    hill_key = [2 3; 1 4];
    
    for round = 1:rounds
        right = additive_cipher(right, additive_key);
        right = rail_fence_cipher(right, 2);
        right = hill_cipher(right, hill_key);
        right = keyed_transposition_cipher(right, 'key');
        
        % Swap left and right
        temp = left;
        left = right;
        right = temp;
    end

    ciphertext = [left right];
end

function plaintext = feistel_decipher(ciphertext, key, rounds)
    len = length(ciphertext);
    left = ciphertext(1:floor(len/2));
    right = ciphertext(floor(len/2)+1:end);

    additive_key = key;
    hill_key = [2 3; 1 4];
    
    for round = 1:rounds
        % Swap left and right
        temp = left;
        left = right;
        right = temp;
        
        left = inverse_keyed_transposition_cipher(left, 'key');
        left = inverse_hill_cipher(left, hill_key);
        left = inverse_rail_fence_cipher(left, 2);
        left = inverse_additive_cipher(left, additive_key);
    end

    plaintext = [left right];
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
