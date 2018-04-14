function [ logical_array ] = str2logical( str )
%str2logical() Converts a string to a logical array, based on the char ascii values

% Tyson Cross 1239448

raw_str = dec2bin(uint32(str));
len_str = numel(raw_str);
% parsed_str = reshape(raw_str',[1 len_str]);
% parsed_str = logical(parsed_str(:)'-'0');
logical_array = logical(reshape(raw_str',[1 len_str])-'0');

end

