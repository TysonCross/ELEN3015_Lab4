% conversion utilities
value_64 = intmax('uint64');
bin_64 = dec2binary(value_64);
decimal_64 = bin2decimal(bin_64);
assert(isequal(decimal_64,value_64));

value_32 = intmax('uint32');
bin_32 = dec2binary(value_32);
decimal_32 = bin2decimal(bin_32);
assert(isequal(decimal_32,value_32));

value_16 = intmax('uint16');
bin_16 = dec2binary(value_16);
decimal_16 = bin2decimal(bin_16);
assert(isequal(decimal_16,value_16));

value_8 = intmax('uint8');
bin_8 = dec2binary(value_8);
decimal_8 = bin2decimal(bin_8);
assert(isequal(decimal_8,value_8));

% prompt = 'Enter a decimal value to convert to binary:\n';
% value = input(prompt);
value=8;
bin = dec2binary(value);

a=sprintf('%d', bin); % b is an array.
b=dec2bin(value)

assert(isequal(a,b));
decimal = bin2decimal(bin);
assert(isequal(decimal,value));
disp(bin)