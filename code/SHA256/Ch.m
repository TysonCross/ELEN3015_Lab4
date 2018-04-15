function [ word ] = Ch(x,y,z)
%Ch() implements (x^y)XOR(¬x^z) §4.1.2 (4.2)

% Tyson Cross 1239448

    checkLength(x,32);
    checkLength(y,32);
    checkLength(z,32);
    checkLogical([x y z]);
    a = bitand(x,y);
    b = bitand(~x,z);
    word = bitxor(a,b);
end

