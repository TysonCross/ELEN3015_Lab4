function [ amount ] = updateBalanceOLD( value , filename )
%updateBalance() Summary of this function goes here

if nargin<2
    filename = 'balance.dat';
end

fileID = fopen(filename, 'w');
fprintf(fileID,'%d', value);
fclose(fileID);

amount=value;

end

