disp("Talha 114");

%{
letter = ['a': 'z'];
pt = ['ilikecomputersecurity'];
k = 114;
for i = 1:length(pt)
    pt_no(i) = find(letter == pt(i)) - 1;
end
c = mod(pt_no + k, 26);
cipher = letter(c+1)
ct_no = mod(c - k,26);
pt_new = letter(ct_no + 1)
%}
%-------------------------------------------------------------------

%{
% Get message input from user
message = input('Enter a message to encrypt (alphabetic characters only): ', 's');

% Input validation (check for string and alphabetic characters only)
if ~ischar(message)
  error('Input message must be a string.');
end
alphabet = 'a':'z';
if ~all(ismember(lower(message), alphabet))
  error('Message can only contain alphabetic characters (a-z).');
end

% Get key input from user
key = input('Enter a key (positive integer between 1 and 25): ');

% Input validation (check for positive integer between 1 and 25)
if ~isnumeric(key) || key <= 0 || key >= 26
  error('Key must be a positive integer between 1 and 25.');
end

% Convert the message to lowercase and remove non-alphabetic characters
message = lower(message);
message = message(ismember(message, alphabet));

% Get numerical equivalents of characters
messageNum = double(message) - double('a') + 1;

% Perform encryption (multiplicative cipher)
cipherTextNum = mod(messageNum .* key, 26);
cipherText = char(cipherTextNum + double('a') - 1);

% Decryption (custom logic for modular multiplicative inverse)
gcdResult = gcd(key, 26);
if gcdResult ~= 1
  warning('Multiplicative decryption may not work for all keys. Choose a key coprime to 26 for guaranteed decryption.');
end
invKey = 1;
for i = 1:26
  if mod(i * key, 26) == 1
    invKey = i;
    break;
  end
end

decryptedTextNum = mod(cipherTextNum .* invKey, 26);
decryptedText = char(decryptedTextNum + double('a') - 1);

% Display results
disp('Original Message:');
disp(message);
disp('Encrypted Message:');
disp(cipherText);
disp('Decrypted Message:');
disp(decryptedText);
%}


%-------------------------------------------------------------------------------------------------------

%{

% Get message input from user
message = input('Enter a message to encrypt (alphabetic characters only): ', 's');

% Get key a and b input from user
a = input('Enter key a (positive integer coprime to 26): ');
b = input('Enter key b (non-negative integer): ');

% Convert the message to lowercase and remove non-alphabetic characters
alphabet = 'a':'z';
message = lower(message);
message = message(ismember(message, alphabet));

% Get numerical equivalents of characters
messageNum = double(message) - double('a') + 1;

% Encryption (affine cipher)
cipherTextNum = mod((a * messageNum + b), 26);
cipherText = char(cipherTextNum + double('a') - 1);

% Decryption (alternative approaches for modular multiplicative inverse)

% Using `gcd` and custom logic
invA = 1;
for i = 1:26
  if mod(i * a, 26) == 1
    invA = i;
    break;
  end
end

decryptedTextNum = mod(invA * (cipherTextNum - b), 26);


decryptedText = char(decryptedTextNum + double('a') - 1);

% Display results
disp('Original Message:');
disp(message);
disp('Encrypted Message:');
disp(cipherText);
disp('Decrypted Message:');
disp(decryptedText);

%}
%-------------------------------------------------------------------------------------------------

% Get message input from user
message = input('Enter a message to encrypt (alphabetic characters only): ', 's');

% Get key input from user
key = input('Enter a key (unique permutation of the alphabet): ', 's');

% Input validation (check for string and alphabetic characters only)
if ~ischar(message)
  error('Input message must be a string.');
end
alphabet = 'a':'z';
if ~all(ismember(lower(message), alphabet))
  error('Message can only contain alphabetic characters (a-z).');
end
if ~all(ismember(lower(key), alphabet)) || ~isequal(length(key), 26) 
  error('Key must be a unique permutation of the alphabet (no duplicates).');
end

% Convert the message to lowercase and remove non-alphabetic characters
message = lower(message);
message = message(ismember(message, alphabet));

% Get numerical equivalents of characters (a=1, b=2, etc.)
messageNum = double(message) - double('a') + 1;

% Encryption (substitution based on key)
cipherTextNum = mod(messageNum - 1, 26) + 1; % Adjust for 0-based indexing
cipherText = char(key(cipherTextNum));

% Decryption (reverse substitution based on key)
[~, indices] = ismember(cipherText, key);
decryptedTextNum = indices;
decryptedText = char(double('a') + decryptedTextNum - 1);

% Display results
disp('Original Message:');
disp(message);
disp('Encrypted Message:');
disp(cipherText);
disp('Decrypted Message:');
disp(decryptedText);

