function checkLogical(input)
%checkLogical() checks the input is of type logical

% Tyson Cross 1239448

    if ~islogical(input)
        error('Input must be logical array')
    end
end