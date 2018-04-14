function [ str ] = logical2str( logical_array )
%str2logical() Converts a logical array to a string based on the char ascii values
% The array is assumed to be a padded logical array, with the following structure:
%   [ logical_array 1 padded_zeros length_of_message ]

% Tyson Cross 1239448

if ~islogical(logical_array)
    error('Input must be a logical array')
end

bin_array = reshape(logical_array',1,[]);                          	% flatten into single row
len = bin_array(end-63:end);                                        % extract message length
len_dec = bin2decimal(len);
bin_array = bin_array(1:len_dec);                                   % trim padding
% bin_array = bin_array(1:floor(numel(bin_array)/7)*7);              % <- not be required if message was char string
raw_decoded_msg = reshape(bin_array, 7, [])';                       % parse for decoding individual characters
str = char(bin2dec(num2str(raw_decoded_msg)))';                    	% decode into ASCII

end