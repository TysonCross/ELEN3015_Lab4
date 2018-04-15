function [ word ] = E_0(x)
    checkLogical(x);
    checkLength(x,32);
    word = bitxor(bitxor(ROTR(x,2),ROTR(x,13)),ROTR(x,22));
end