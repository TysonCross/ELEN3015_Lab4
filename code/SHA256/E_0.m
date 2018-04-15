function [ word ] = E_0(x)
%E_0() implements (ROTR^2(x))XOR(ROTR^13(x))XOR(ROTR^22(x)) §4.1.2 (4.4)
%
% ROTR^n(x) = (x >> n) v (x << w-n) §2.2.2 
% x is a w-bit word and 0 <= n < w

% Tyson Cross 1239448

    checkLogical(x);
    checkLength(x,32);
    word = bitxor(bitxor(ROTR(x,2),ROTR(x,13)),ROTR(x,22));
end