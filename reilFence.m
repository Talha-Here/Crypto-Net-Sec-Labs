disp("gggg")
function encrypted_text = rail_fence_cipher(text, key)
  % Create the rail matrix with appropriate size
  rail = char(zeros(key, length(text)));  % Pre-allocate character matrix

  % Track direction and initialize row and column counters
  dir_down = false;
  row = 1;
  col = 1;

  % Fill the rail matrix in zig-zag fashion
  for i = 1:length(text)
    rail(row, col) = text(i);

    % Update direction and row based on position (handle edge cases)
    if row == 1
      dir_down = true;
    elseif row == key
      dir_down = false;
    end
    row = row + (dir_down * 2 - 1);  % Concise way to update row

    col = col + 1;  % Avoid unnecessary checks for column overflow
  end

  % Extract the encrypted text from the filled rail matrix
  encrypted_text = rail(:);
  encrypted_text = encrypted_text';  % Convert to row vector for consistency
end

function decrypted_text = inverse_rail_fence_cipher(cipher, key)
  % Create the rail matrix with appropriate size
  rail = char(zeros(key, length(cipher)));  % Pre-allocate character matrix

  % Track direction and initialize row and column counters
  dir_down = false;
  row = 1;
  col = 1;

  % Place markers in the rail matrix to track positions
  for i = 1:length(cipher)
    if row == 1
      dir_down = true;
    elseif row == key
      dir_down = false;
    end
    row = row + (dir_down * 2 - 1);

    rail(row, col) = '*';
    col = col + 1;
  end

  % Fill the rail matrix with cipher text based on marker positions
  index = 1;
  for i = 1:key
    for j = 1:length(cipher)
      if (rail(i, j) == '*') && (index <= length(cipher))
        rail(i, j) = cipher(index);
        index = index + 1;
      end
    end
  end

  % Decrypt by reading the rail matrix in zig-zag fashion
  decrypted_text = '';
  row = 1;
  col = 1;
  for i = 1:length(cipher)
    if row == 1
      dir_down = true;
    elseif row == key
      dir_down = false;
    end
    row = row + (dir_down * 2 - 1);

    if (rail(row, col) ~= '*')
      decrypted_text = [decrypted_text, rail(row, col)];
    end
    col = col + 1;
  end
end



plaintext = 'talha';
key = 2;


encrypted_text = rail_fence_cipher(plaintext, key);
fprintf('Encrypted Text: %s\n', encrypted_text);

decrypted_text = inverse_rail_fence_cipher(encrypted_text, key);
fprintf('Decrypted Text: %s\n', decrypted_text);
%fprintf('Rail Fence Cipher:\nEncrypted: %s\nDecrypted: %s\n\n', rail_fence_encrypted, rail_fence_decrypted);


