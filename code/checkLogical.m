function checkLogical(input)
    if ~islogical(input)
        error('Input must be logical array')
    end
end