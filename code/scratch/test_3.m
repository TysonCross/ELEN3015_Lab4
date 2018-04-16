% Tyson Cross 1239448

% a = [1:512];
% b = reshape(a,64,[]);
% 
% [r,c] = size(b)
% d  = 8;
% out  = reshape(b',[c,r/d,d]);
% % new = permute(out,[3,1,2]);
% 
% 
% num2str((out(1,:,1)))

% clc;

a = [char(double('a'):double('z')) char(double('A'):double('Z'))];
a = repmat(a ,[1 32]);
a = a(1:1024);
b = reshape(a,512,[])';
[r,c] = size(b')
w  = 32;
out  =  permute(reshape(b',[w,r/w,c]),[3,2,1]);
[x y z] = size(out);
d = sprintf('%s',out(1,1,:))
sprintf('%s',b(1,1:32))


word_array = cell(r,c,w);

% M_flat = reshape(padded_message,512,[])';
% [n, m] = size(M_flat);
% [row,col] = size(M_flat');
% word_length  = 32;
% M_temp  = permute(reshape(M_flat',[word_length,row/word_length,col]),[3,2,1]);
% [r,c,w] = size(M_temp);
% M = num2cell(M_temp,[r,c]);
% W = cell(r,c,w);
