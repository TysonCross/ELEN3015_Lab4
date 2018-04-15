function [ output ] = flattenlogical( input )
%flattenlogical() Reduces a 1x1xW logical array to a 1xW logical array

% Tyson Cross 1239448

output = char2logical(logical2char(input));

end

