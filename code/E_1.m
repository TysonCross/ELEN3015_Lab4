function [ word ] = E_1(x)
    checkLogical(x);
    checkLength(x,32);
    word = bitxor(bitxor(ROTR(x,6),ROTR(x,11)),ROTR(x,25));
end