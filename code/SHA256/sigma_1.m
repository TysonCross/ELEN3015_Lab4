function [ word ] = sigma_1(x)
%sigma_1() implements (ROTR^17(x))XOR(ROTR^19(x))XOR(SHR^10(x)) §4.1.2 (4.7)
%
% ROTR^n(x) = (x >> n) v (x << w-n)
% SHR^n(x) = (x >> n)
% x is a w-bit word and 0 <= n < w

% Tyson Cross 1239448

    checkLogical(x);
    checkLength(x,32);
    word = bitxor(bitxor(ROTR(x,17),ROTR(x,19)),SHR(x,10));
end