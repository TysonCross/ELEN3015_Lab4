function [ word ] = Maj(x,y,z)
%Maj() implements (x^y)XOR(x^z)XOR(y^z) §4.1.2 (4.3)

% Tyson Cross 1239448
    checkLength(x,32);
    checkLength(y,32);
    checkLength(z,32);
    checkLogical([x y z]);
    word = bitxor(bitxor(x,y),z);
end