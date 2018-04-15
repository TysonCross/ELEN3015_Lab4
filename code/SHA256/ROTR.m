function [word] = ROTR(x,n)
%ROTR() implements the rotate-right (circular right shift) §2.2.2 
%
% ROTR^n(x) = (x >> n) v (x << w-n)
% x is a w-bit word and 0 <= n < w

% Tyson Cross 1239448

    checkLogical(x);
    checkLength(x,32);
    checkRange(n,0,32);
    word = circshift(x,[0 n]);
end