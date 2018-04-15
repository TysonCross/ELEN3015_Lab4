function [ word ] = sigma_0(x)
% Tyson Cross 1239448

    checkLogical(x);
    checkLength(x,32);
    word = bitxor(bitxor(ROTR(x,7),ROTR(x,18)),SHR(x,3));
end