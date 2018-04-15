function [word] = ROTL (x,n)
% Tyson Cross 1239448

    checkLogical(x);
    checkLength(x,32);
    checkRange(n,0,32);
    word = circshift(x,[0 -n]);
end