function [ H M ] = hash( message )
%hashSHA256() hashes an input message with an implementation of SHA256
% Input message must be split into 512-bit blocks
% See FIPS PUB 180-4 forthe implementation standard
% http://dx.doi.org/10.6028/NIST.FIPS.180-4

% Tyson Cross 1239448

%{
    a,b,c,d,e,f,g,h : working variables
    W : words of the message schedule
    K: Constants
    H: Hash 
%}

% K is first 32 bits of the fractional parts of the cube roots of the first 64 prime numbers
K = dec2bin(hex2dec(...
    [   '428a2f98';'71374491';'b5c0fbcf';'e9b5dba5';'3956c25b';'59f111f1';'923f82a4';'ab1c5ed5';...
        'd807aa98';'12835b01';'243185be';'550c7dc3';'72be5d74';'80deb1fe';'9bdc06a7';'c19bf174';...
        'e49b69c1';'efbe4786';'0fc19dc6';'240ca1cc';'2de92c6f';'4a7484aa';'5cb0a9dc';'76f988da';...
        '983e5152';'a831c66d';'b00327c8';'bf597fc7';'c6e00bf3';'d5a79147';'06ca6351';'14292967';...
        '27b70a85';'2e1b2138';'4d2c6dfc';'53380d13';'650a7354';'766a0abb';'81c2c92e';'92722c85';...
        'a2bfe8a1';'a81a664b';'c24b8b70';'c76c51a3';'d192e819';'d6990624';'f40e3585';'106aa070';...
        '19a4c116';'1e376c08';'2748774c';'34b0bcb5';'391c0cb3';'4ed8aa4a';'5b9cca4f';'682e6ff3';...
        '748f82ee';'78a5636f';'84c87814';'8cc70208';'90befffa';'a4506ceb';'bef9a3f7';'c67178f2']));

% H is first 32 bits of the fractional parts of the square roots of the first 8 prime numbers
H = dec2bin(hex2dec(...
    [ '6a09e667'; 'bb67ae85'; '3c6ef372'; 'a54ff53a'; '510e527f'; '9b05688c'; '1f83d9ab'; '5be0cd19' ]));


% message preprocessing
if ~islogical(message)
    if ischar(message)
        message = str2logical(message);
    elseif isnumeric(message)
        message = logical(message);
    end
end

% Pad to make the message a multiple of 512
M = padder(message);
assert(mod(numel(M),512)==0);

% Parse into n blocks of 512 bits
M = reshape(M,[],512);
[n m] = size(M);

% Process message blocks
for i=1:n
    for t=1:15
        W = M(i,t);
    end
end
   
end

function [ word ] = Ch(x,y,z)
    a = bitand(x,y);
    b = bitand(bitcmp(x),z);
    word = bitxor(a,b);
end

function [ word ] = Maj(x,y,z)
    word = bitxor(bitxor(x,y),z);
end

function [ output ] = E_1(x)
end

function [ output ] = E_2(x)
end

function [ output ] = sigma_1(x)
end

function [ output ] = sigma_2(x)
end

function [output] = ROTL ( x, n)
end

function [output] = ROTR ( x, n)
end

function [output] = SHR ( x, n)
end