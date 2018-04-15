function [ word ] = sigma_1(x)
% Tyson Cross 1239448

    checkLogical(x);
    checkLength(x,32);
    word = bitxor(bitxor(ROTR(x,17),ROTR(x,19)),SHR(x,10));
end