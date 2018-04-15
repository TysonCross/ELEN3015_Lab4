function [ word ] = E_1(x)
%E_1() implements (ROTR^6(x))XOR(ROTR^11(x))XOR(ROTR^25(x)) §4.1.2 (4.5)
%
% ROTR^n(x) = (x >> n) v (x << w-n) §2.2.2 
% x is a w-bit word and 0 <= n < w

% Tyson Cross 1239448

    checkLogical(x);
    checkLength(x,32);
    word = bitxor(bitxor(ROTR(x,6),ROTR(x,11)),ROTR(x,25));
end