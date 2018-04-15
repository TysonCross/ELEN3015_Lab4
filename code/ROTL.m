function [word] = ROTL (x,n)
    checkLogical(x);
    checkLength(x,32);
    checkRange(n,0,32);
    word = circshift(x,[0 -n]);
end