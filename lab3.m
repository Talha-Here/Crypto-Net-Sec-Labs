disp("TALHA 114");
%{
letter = ['a':'z'];
pt = 'ilikecomputersecurity';
key = 'sight';
a = length(pt);
key_rep = repmat(key,1,a);
for i = 1:length(pt)
    key1(i) = key_rep(i);
end
for i = 1:length(pt)
    pt_no(i) = find(letter == pt(i)) - 1;
    key1(i) = find(letter == key_rep(i)) -1;
end
c= mod(pt_no + key1 , 26);
cipher = letter(c+1)
ct_no = mod(c-key1,26);
pt_new = letter(ct_no+1)

%}


%{

% Rail Fence Cipher Encryption and Decryption without using a function

% Define the plaintext
plaintext = 'over the crimson sky';
depth = 5;

% Encryption
rail_fence = zeros(depth, length(plaintext));
index = 1;
down = true;

for i = 1:depth
    rail_fence(i, :) = '*'; % Fill with placeholder character
end

for i = 1:length(plaintext)
    rail_fence(index, i) = plaintext(i);
    
    if down
        index = index + 1;
    else
        index = index - 1;
    end
    
    if index == depth
        down = false;
    elseif index == 1
        down = true;
    end
end

ciphertext = reshape(rail_fence, 1, []);
% Convert ASCII codes to characters
ciphertext = char(ciphertext);
disp('Encrypted Text:');
disp(ciphertext);

% Decryption
rail_fence = reshape(ciphertext, depth, []);
plaintext_decrypt = '';

index = 1;
down = true;

for i = 1:length(plaintext)
    plaintext_decrypt = [plaintext_decrypt, rail_fence(index, i)];
    
    if down
        index = index + 1;
    else
        index = index - 1;
    end
    
    if index == depth
        down = false;
    elseif index == 1
        down = true;
    end
end

disp('Decrypted Text:');
disp(plaintext_decrypt);

%}

% Keyed Transposition Cipher Encryption and Decryption without using a function

% Define the plaintext
function ciphertext = keyedTransposition(pt)

letters = ['a':'z'];
key = [2,5,4,3,1,6];
key2 = key;  % Duplicate key for second pass

% Loop for first transposition
for i = 1:length(pt)
  j = 6;
  z = i;
  for q = 1:length(pt)
    if (key(z) > key(q) && key(q) ~= 10)
      j = q;
      z = q;
    end
  end
  key(j) = 10;
  ct(i) = pt(j);
end

% Loop for second transposition (using ct from first pass)
for i = 1:length(ct)
  j = 6;
  z = i;
  for q = 1:length(ct)
    if (key2(z) > key2(q) && key2(q) ~= 10)
      j = q;
      z = q;
    end
  end
  key2(j) = 10;
  pt(i) = ct(i);  % Overwrite pt with transposed ct
end

% Assign final ciphertext (transposed pt)
ciphertext = pt;

end


pt = 'letus ';
ciphertext = keyedTransposition(pt);
disp(ciphertext);

