function [ word ] = sigma_0(x)
%sigma_0() implements (ROTR^7(x))XOR(ROTR^18(x))XOR(SHR^3(x)) §4.1.2 (4.6)
%
% ROTR^n(x) = (x >> n) v (x << w-n)
% SHR^n(x) = (x >> n)
% x is a w-bit word and 0 <= n < w

% Tyson Cross 1239448

    checkLogical(x);
    checkLength(x,32);
    word = bitxor(bitxor(ROTR(x,7),ROTR(x,18)),SHR(x,3));
end