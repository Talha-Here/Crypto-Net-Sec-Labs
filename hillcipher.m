disp("TALHA 114");
function encryptedText = hillCipher(message, key)

% Function to perform Hill Cipher encryption

% Convert message to uppercase and remove spaces
message = upper(message);
message = message(isspace(message) == 0);

% Check for odd number of letters (add 'X' if needed)
if (mod(length(message), 2) ~= 0)
  message = [message, 'X'];
end

% Convert letters to numbers (A=0, Z=25)
alphabet = 'A':'Z';
numericalMessage = zeros(1, length(message));
for i = 1:length(message)
  numericalMessage(i) = find(alphabet == message(i)) - 1;
end

% Break message into bigrams (blocks of 2 letters)
bigrams = reshape(numericalMessage, 2, []);

% Encryption using key matrix
encryptedBigrams = mod((key * bigrams), 26);

% Convert numbers back to letters
encryptedText = '';
for i = 1:size(encryptedBigrams, 2)
  encryptedText = [encryptedText, alphabet(encryptedBigrams(1, i) + 1), alphabet(encryptedBigrams(2, i) + 1)];
end

end

% Example usage (replace "ALICE" with your name)
message = "talha";
key = [5 6; 2 3];

encryptedText = hillCipher(message, key);

disp(['Plaintext: ', message]);
disp(['Encrypted Text: ', encryptedText]);
