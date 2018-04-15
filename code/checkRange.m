function checkRange(input,beg,fin)
    if ~(beg<=input<fin)
        error('Input is not within valid range')
    end
end