function [ bin ] = dec2binary( decimal )

if decimal > intmax('uint64')
   error('Input cannot be greater than intmax(''utint64'')')
end

if decimal > intmax('uint32')
    num_of_bits = 64;
elseif decimal > intmax('uint16')
    num_of_bits = 32;
elseif decimal > intmax('uint8')
    num_of_bits = 16;
else
    num_of_bits = 8;
end
        
decimal = uint64(decimal);
% value = uint64(num_of_bits-1:-1:0);                      	% Array of exponents for binary entries
value = uint64(0:num_of_bits-1);                      	% Array of exponents for binary entries
base = uint64(2).^value;                              	% Decimal values for each bit

if decimal > sum(uint64(base), 'native')
   error('Not enough bits specified to represent decimal value')
end

bin = false(1,num_of_bits);                             % Initialise logical array
i = num_of_bits;
while decimal>0
    if decimal >= base(i)                               % For each applicable column of 2^i
        decimal = decimal - base(i);                    % Reduce the value of decimal
        bin(i) = true;                                  % Set the binary bit
    end
    i = i - 1;                                          % Update the iterating count
end

end