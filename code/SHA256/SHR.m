function [word] = SHR(x,n)
%SHR() implements the shift-right operation §2.2.2 
%
% SHR^n(x) = (x >> n)
% x is a w-bit word and 0 <= n < w

% Tyson Cross 1239448

    checkLength(x,32);
    checkLogical(x);
    a = x(1:end-n);             % <- crop rightmost n bits
    z = false(1,n);             % create logical array of n zeros
    word = [z a];            	% pad to complete shift
    assert(isequal(length(word),length(x)));
end