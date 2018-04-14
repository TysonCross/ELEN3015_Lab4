function [ decimal ] = bin2decimal( bin )

if numel(bin)>64
    error('Input cannot be greater than 64-bits')
end

value = uint64(length(bin)-1:-1:0);                         % Array of exponents from binary entries
base = uint64(2).^value;                                    % Decimal values for each bit
decimal = sum(base.*uint64(bin), 'native');                 % Sum the entries

end
