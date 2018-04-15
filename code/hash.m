function [ digest ] = hash(message)
%hashSHA256() hashes an input message with an implementation of SHA256
% Input message is padded and split into 512-bit blocks.
% Output is a 256-bit hexidecimal digest
% See FIPS PUB 180-4 for the implementation standard
% http://dx.doi.org/10.6028/NIST.FIPS.180-4

% Tyson Cross 1239448

%{
    a,b,c,d,e,f,g,h : working variables
    W : words of the message schedule
    K: Constants
    H: Hash value
%}

a = false(1,32);
b = false(1,32);
c = false(1,32);
d = false(1,32);
e = false(1,32);
f = false(1,32);
g = false(1,32);
h = false(1,32);

% K is first 32 bits of the fractional parts of the cube roots of the first 64 prime numbers
K1 = dec2bin(hex2dec(...
    [   '428a2f98';'71374491';'b5c0fbcf';'e9b5dba5';'3956c25b';'59f111f1';'923f82a4';'ab1c5ed5';...
        'd807aa98';'12835b01';'243185be';'550c7dc3';'72be5d74';'80deb1fe';'9bdc06a7';'c19bf174';...
        'e49b69c1';'efbe4786';'0fc19dc6';'240ca1cc';'2de92c6f';'4a7484aa';'5cb0a9dc';'76f988da';...
        '983e5152';'a831c66d';'b00327c8';'bf597fc7';'c6e00bf3';'d5a79147';'06ca6351';'14292967';...
        '27b70a85';'2e1b2138';'4d2c6dfc';'53380d13';'650a7354';'766a0abb';'81c2c92e';'92722c85';...
        'a2bfe8a1';'a81a664b';'c24b8b70';'c76c51a3';'d192e819';'d6990624';'f40e3585';'106aa070';...
        '19a4c116';'1e376c08';'2748774c';'34b0bcb5';'391c0cb3';'4ed8aa4a';'5b9cca4f';'682e6ff3';...
        '748f82ee';'78a5636f';'84c87814';'8cc70208';'90befffa';'a4506ceb';'bef9a3f7';'c67178f2']));
for i=1:64
    K(i,:) = char2logical(K1(i,:));
    assert(strcmp(logical2char(K(i,:)),K1(i,:)));
end
    
% H is first 32 bits of the fractional parts of the square roots of the first 8 prime numbers
H1 = dec2bin(hex2dec(...
    [ '6a09e667'; 'bb67ae85'; '3c6ef372'; 'a54ff53a'; '510e527f'; '9b05688c'; '1f83d9ab'; '5be0cd19' ]));
H = false(1,8,32);
for i=1:8
    H(1,i,:) = char2logical(H1(i,:));
    assert(strcmp(logical2char(H(1,i,:)),H1(i,:)));
end
    
% Message preprocessing
if ~islogical(message)
    if ischar(message)
        message = str2logical(message);
    elseif isnumeric(message)
        message = logical(message);
    end
end

% Pad to make the message a multiple of 512
padded_message = padder(message);
assert(mod(numel(padded_message),512)==0);

% Parse into n blocks of 512 bits
M_flat = reshape(padded_message,512,[])';
[n, ~] = size(M_flat);
[row,col] = size(M_flat');
word_length  = 32;
mod_value = 2^32;
M = permute(reshape(M_flat',[word_length,row/word_length,col]),[3,2,1]);
[x,y,z] = size(M);
W = false(x,y,z);
clear x y z row col M_flat ;

% Process message blocks
for i=2:n+1
    
    for t=1:16
        W(i-1,t,:) = M(i-1,t,:);
    end
    
    for t=17:64
        alpha = sigma_1(flattenlogical(W(i-1,t-2,:)));
        beta = flattenlogical(W(i-1,t-15,:));
        delta = sigma_0(flattenlogical(W(i-1,t-15,:)));
        gamma = flattenlogical(W(i-1,t-16,:));
        epsilon = mod_addition(alpha, beta, delta, gamma);
        W(i-1,t,:) = flattenlogical(epsilon);
        clear alpha beta gamma delta eplison;
    end
    
    a = flattenlogical(H(i-1,1,:));
    b = flattenlogical(H(i-1,2,:));
    c = flattenlogical(H(i-1,3,:));
    d = flattenlogical(H(i-1,4,:));
    e = flattenlogical(H(i-1,5,:));
    f = flattenlogical(H(i-1,6,:));
    g = flattenlogical(H(i-1,7,:));
    h = flattenlogical(H(i-1,8,:));
    
    for t=1:64
        alpha = E_1(e);
        beta = Ch(e,f,g);
        delta = flattenlogical(K(t,:));
        gamma = flattenlogical(W(i-1,t,:));
        T_1 = mod_addition(h, alpha, beta, delta, gamma);
        clear alpha beta gamma delta;
        alpha = E_0(a);
        beta = Maj(a,b,c);
        T_2 = mod_addition(alpha, beta);
        clear alpha beta;
        h = g;
        g = f;
        e = mod_addition(d, T_1);
        d = c;
        c = b;
        b = a;
        a = mod_addition(T_1, T_2);
    end
    
    H(i,1,:) = mod_addition(a, flattenlogical(H(i-1,1,:)));
    H(i,2,:) = mod_addition(bin2decimal(b), flattenlogical(H(i-1,2,:)));
    H(i,3,:) = mod_addition(c, flattenlogical(H(i-1,3,:)));
    H(i,4,:) = mod_addition(d, flattenlogical(H(i-1,4,:)));
    H(i,5,:) = mod_addition(e, flattenlogical(H(i-1,5,:)));
    H(i,6,:) = mod_addition(f, flattenlogical(H(i-1,6,:)));
    H(i,7,:) = mod_addition(g, flattenlogical(H(i-1,7,:)));
    H(i,8,:) = mod_addition(h, flattenlogical(H(i-1,8,:)));
    
    for j=1:8
        H_N{j} = dec2hex(bin2decimal(logical2char(H(i,j,:))));
    end
end

digest = strjoin(H_N,' ');

end
