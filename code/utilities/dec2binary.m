function [ bin ] = dec2binary( decimal, num_of_bits )
%dec2binary() converts an unsigned decimal value to a fixed length binary value
% if the bitdepth is not specified, then an appropriate fixed length is
% chosen, or 64,32,16 or 8 bits. Accurate conversion from 8 to
% 64-bits is supported, for decimal values from 0 to intmax('uint64').

% Tyson Cross 1239448

if decimal > intmax('uint64')
   error('Input cannot be greater than intmax(''utint64'')')
end

if nargin<2
    if decimal > intmax('uint32')
        num_of_bits = 64;
    elseif decimal > intmax('uint16')
        num_of_bits = 32;
    elseif decimal > intmax('uint8')
        num_of_bits = 16;
    else
        num_of_bits = 8;
    end
end
        
decimal = uint64(decimal);
value = uint64(num_of_bits-1:-1:0);                      	% Array of exponents for binary entries
base = uint64(2).^value;                              	% Decimal values for each bit

if decimal > sum(uint64(base), 'native')
   error('Not enough bits specified to represent decimal value')
end

bin = false(1,num_of_bits);                             % Initialise logical array
for i=1:num_of_bits
    if decimal >= base(i)                               % For each applicable column of 2^i
        decimal = decimal - base(i);                    % Reduce the value of decimal
        bin(i) = true;                                  % Set the binary bit
    end
end

end