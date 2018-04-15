function checkRange(input,beg,fin)
%checkRange() checks that the input is within a valid range
% Tyson Cross 1239448

    if ~(beg<=input<fin)
        error('Input is not within valid range')
    end
end