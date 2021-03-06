function [output] = mod_addition(varargin)
%mod_addition() implements addition modulo 2^32  �2.2.2

% Tyson Cross 1239448

    value = uint64(0);
    mod_value = uint64(2^32);
    for i=1:length(varargin)
        value = value + bin2decimal(varargin{i});
    end
    output = dec2binary(mod(value,mod_value),32);
end