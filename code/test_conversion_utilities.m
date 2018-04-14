% Tyson Cross 1239448
clc; clear all;

% conversion utilities tests

value_64 = intmax('uint64')/2;
bin_64 = dec2binary(value_64);
decimal_64 = bin2decimal(bin_64);
assert(isequal(decimal_64,value_64));

value_32 = intmax('uint32')/2;
bin_32 = dec2binary(value_32);
decimal_32 = bin2decimal(bin_32);
assert(isequal(decimal_32,value_32));

value_16 = intmax('uint16')/2;
bin_16 = dec2binary(value_16);
decimal_16 = bin2decimal(bin_16);
assert(isequal(decimal_16,value_16));

value_8 = intmax('uint8')/2;
bin_8 = dec2binary(value_8);
decimal_8 = bin2decimal(bin_8);
assert(isequal(decimal_8,value_8));
disp('dec2binary() and bin2decimal() passed basic functionality tests')


try bin_test = dec2binary(value_test,32);
catch ME
    disp([  'dec2binary() correctly threw an error (due to insufficient bitsize)' ])
end

try bin_test = dec2binary(18446744073709551616);
catch ME
    disp([  'dec2binary() correctly threw an error (due to a decimal value being too large)' ])
end

try decimal_test = bin2decimal(true(1,65));
catch ME
    disp([  'bin2decimal() correctly threw an error (due to a binary value being too large)' ])
end

% prompt = 'Enter a decimal value to convert to binary:\n';
% value = input(prompt);
value = randi(intmax('uint32'));
bin = dec2binary(value);
decimal = bin2decimal(bin);
assert(isequal(decimal,value));
% fprintf('%d', bin)

disp('---------------------------------------------------')
disp('All tests passed for dec2binary() and bin2decimal()')
disp('---------------------------------------------------')
disp(' ')

bin_array = dec2binary(intmax('uint32')/2);
char_array = logical2char(bin_array);
bin_array2 = char2logical(char_array);
char_array2 = logical2char(bin_array);
assert(isequal(char_array,char_array2));
assert(isequal(bin_array,bin_array2));
disp('logical2char() and char2logical() passed basic functionality tests')


try char_array = logical2char(char_array2);
catch ME
    disp([  'logical2char() correctly threw an error (due to invalid input type)' ])
end

try bin_array = char2logical(bin_array2);
catch ME
    disp([  'char2logical() correctly threw an error (due to invalid input type)' ])
end
disp('------------------------------------------------------')
disp('All tests passed for logical2char() and char2logical()')
disp('------------------------------------------------------')
disp(' ')

