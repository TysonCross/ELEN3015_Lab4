function checkRange(input,beg,fin)
% Tyson Cross 1239448

    if ~(beg<=input<fin)
        error('Input is not within valid range')
    end
end