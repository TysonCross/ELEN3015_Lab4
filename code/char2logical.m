function [ logical_array ] = char2logical( char_array )
%char2logical() converts a char array (assumed to be of '0' and '1' chars) to a logical array

% Tyson Cross 1239448

if ~ischar(char_array)
    error('Input must be a char array')
end

logical_array = logical(char_array(:)'-'0');

end

