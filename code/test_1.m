clc; clear all;

prompt = 'Enter something to hash: ';
str = input(prompt, 's');
% str = ['This is a short message I wish to hash'];

% encode
raw_message = dec2bin(uint32(str));
len_message = numel(raw_message);
message = reshape(raw_message,[1 len_message]);
clear raw_message;

bin_message = padder(message);                              % make the message a multiple of 512


% decode
raw_decoded_msg = reshape(message, [numel(message)/7 7]);
decoded_msg = char(bin2dec(raw_decoded_msg))';
clear raw_decoded_msg;

assert(strcmp(str,decoded_msg)==1);

disp(message)
disp(decoded_msg)

% message = logical(randi(2, [1 len]) - 1)
% getByteStreamFromArray(message)
