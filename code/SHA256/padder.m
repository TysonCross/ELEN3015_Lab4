function [ M ] = padder( input )
%padder() ensures that a message length is a multiple of 512
% The logical array is appended with a single '1' bit, then
% padded with 448 zeros, then the length of the message in binary:
%   [ logical_array 1 padded_zeros length_of_message ]

% Tyson Cross 1239448

if islogical(input)
    msg = input;
elseif ischar(input)
    msg = str2logical(input);
elseif isnumeric(input)
    msg = str2logical(num2str(input));
end

len = length(msg);
bin_len = dec2binary(len,64);               % 64 bits

k = 0:511;                                  % Brute force find the value of the zero padding
zero_len = k(mod(len + 1 + k, 512) == 448); % to solve the equation len + 1 + k = 448 mod 512
zero_pad = false(1,zero_len);            	% Number of zeros
M = [msg true zero_pad bin_len];            % append the message length in binary (64-bits)
assert(mod(numel(M),512)==0);

end

