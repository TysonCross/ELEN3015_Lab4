% Tyson Cross 1239448

function [ char_array ] = logical2char( logical_array )
%logicaltochar() converts a logical array into a char array

% Tyson Cross 1239448

if ~islogical(logical_array)
        error('Input must be a char array')
end

char_array = repmat('0',1,numel(logical_array));
for i=1:numel(logical_array)
    if logical_array(i)
        char_array(i)='1';
    else
        char_array(i)='0';
    end
end
% char_array = fprintf('%d', logical_array);

end

