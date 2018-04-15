function checkLength(input, len)
    if ~length(input)==len
        error(['Length is not ',num2str(len)])
    end
end