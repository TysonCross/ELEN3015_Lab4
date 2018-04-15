function [ decimal ] = bin2decimal( bin )
%bin2decimal() converts a binary value to an unsigned decimal value
% Accurate conversion from 0 to intmax('uint64') is supported, binary
% values from 8 to 64 bits.

% Tyson Cross 1239448

if numel(bin)>64
    error('Input cannot be greater than 64-bits')
end

if ischar(bin)
    bin = logical(bin(:)'-'0');
end
value = uint64(length(bin)-1:-1:0);                         % Array of exponents from binary entries
base = uint64(2).^value;                                    % Decimal values for each bit
decimal = sum(base.*uint64(bin), 'native');                 % Sum the entries

end
