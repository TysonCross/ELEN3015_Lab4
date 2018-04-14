function [ M ] = padder( message )
%padder() ensures that a message length is a multiple of 512
% The logical array is appended with a single '1' bit, then
% padded with 448 zeros, then the length of the message in binary

len = length(message);
bin_len = dec2bin(len,64);                  % 64 bits

k = 0:512;                                  % Brute force find the value of the zero padding
zero_len = k(mod(len + 1 + k, 512) == 448); % to solve the equation len + 1 + k = 448 mod 512
z(1:zero_len)='0';
M = [message '1' z bin_len];                  % append the message length in binary (64-bits)
assert(mod(numel(M),512)==0);

end

