function [ word ] = Ch(x,y,z)
% Tyson Cross 1239448

    checkLength(x,32);
    checkLength(y,32);
    checkLength(z,32);
    checkLogical([x y z]);
    a = bitand(x,y);
    b = bitand(~x,z);
    word = bitxor(a,b);
end

