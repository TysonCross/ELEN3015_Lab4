function checkLength(input, len)
%checkLength() checks the input length

% Tyson Cross 1239448

    if ~length(input)==len
        error(['Length is not ',num2str(len)])
    end
end