function [word] = SHR (x,n)
% Tyson Cross 1239448

    checkLength(x,32);
    checkLogical(x);
    a = x(1:end-n);             % <- crop rightmost n bits
    z = false(1,n);             % create logical array of n zeros
    word = [z a];            	% pad to complete shift
    assert(isequal(length(word),length(x)));
end