clc; clear all;

n = 3;

a = [ true false false true false false true]
b = circshift(a, [0 n])     % <- shift circular right
c = circshift(a, [0 -n])    % <- shift circular left

d = a(1:end-n);             % <- bitshift right
z = false(1,n);             %
d = [z d]                   % pad to complete shift
    
e = bitand(a,b)
f = bitor(a,b)
g = bitxor(~b,c)