function [ word ] = Maj(x,y,z)
% Tyson Cross 1239448

    checkLength(x,32);
    checkLength(y,32);
    checkLength(z,32);
    checkLogical([x y z]);
    word = bitxor(bitxor(x,y),z);
end