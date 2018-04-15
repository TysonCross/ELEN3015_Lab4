function [output] = mod_addition(varargin)
    value = 0;
    mod_value = 2^32;
    for i=1:length(varargin)
        value = value + varargin{i};
    end
    output = mod(value,mod_value);
end