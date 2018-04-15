function [ digest ] = hash( message )
%hash() hashes an input message with an implementation of SHA256
%
% Input message is padded and split into 512-bit blocks.
% Output is a 256-bit hexidecimal digest (char)
% See FIPS PUB 180-4 for the implementation standard
% http://dx.doi.org/10.6028/NIST.FIPS.180-4

% Tyson Cross 1239448

% Initialise working variables
a = false(1,32);
b = false(1,32);
c = false(1,32);
d = false(1,32);
e = false(1,32);
f = false(1,32);
g = false(1,32);
h = false(1,32);

word_length  = 32;
mod_value = 2^32;

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
    
% H is first 32 bits of the fractional parts of the square roots of the first 8 prime numbers
H1 = dec2bin(hex2dec(...
    [ '6a09e667'; 'bb67ae85'; '3c6ef372'; 'a54ff53a'; '510e527f'; '9b05688c'; '1f83d9ab'; '5be0cd19' ]));

K = false(64,32);
for i=1:64
    K(i,:) = char2logical(K1(i,:));
    assert(strcmp(logical2char(K(i,:)),K1(i,:)));
end

H = false(1,8,32);
for i=1:8
    H(1,i,:) = char2logical(H1(i,:));
    assert(strcmp(logical2char(H(1,i,:)),H1(i,:)));
end
    
% Message preprocessing
if ~islogical(message)
    if ischar(message)
        message_logical = str2logical(message);
    elseif isnumeric(message)
        message_logical = logical(message);
    end
end

% Pad to make the message a multiple of 512
message_padded = padder(message_logical);

% Parse into n blocks of 512 bits, then reshape into 3D matrix (Nx16x32) 
message_flat = reshape(message_padded,512,[])';
[N, ~] = size(message_flat);
[row,col] = size(message_flat');
M = permute(reshape(message_flat',[word_length,row/word_length,col]),[3,2,1]);

% Initialise W (word schedule)
[x,y,z] = size(M);
W = false(N*x,y,z);

clear x y z row col message_padded message_flat message_logical K1 H1 input ;

% Process message blocks (total of N message blocks)
% Matlab indexing starts at 1, unfortunately, so H(0) must be treated as H(1)
for i=1:N; j=i+1;

    % Hash computation, Stage 1 
    for t=1:16
        W(i,t,:) = M(i,t,:);
    end
    
    for t=17:64
        alpha = sigma_1(flattenlogical(W(i,t-2,:)));
        beta = flattenlogical(W(i,t-15,:));
        delta = sigma_0(flattenlogical(W(i,t-15,:)));
        gamma = flattenlogical(W(i,t-16,:));
        epsilon = mod_addition(alpha, beta, delta, gamma);
        W(i,t,:) = flattenlogical(epsilon);
        clear alpha beta gamma delta eplison;
    end
    
    % Hash computation, Stage 2
    a = flattenlogical(H(i,1,:));
    b = flattenlogical(H(i,2,:));
    c = flattenlogical(H(i,3,:));
    d = flattenlogical(H(i,4,:));
    e = flattenlogical(H(i,5,:));
    f = flattenlogical(H(i,6,:));
    g = flattenlogical(H(i,7,:));
    h = flattenlogical(H(i,8,:));
    
    % Hash computation, Stage 3
    for t=1:64
        alpha = h;
        beta = E_1(e);
        delta = Ch(e,f,g);
        gamma = flattenlogical(K(t,:));
        epsilon = flattenlogical(W(i,t,:));
        T_1 = mod_addition(alpha, beta, delta, gamma, epsilon);
        T_2 = mod_addition(E_0(a), Maj(a,b,c));
        h = g;
        g = f;
        f = e;
        e = mod_addition(d, T_1);
        d = c;
        c = b;
        b = a;
        a = mod_addition(T_1, T_2);
        clear alpha beta gamma delta epsilon;
    end
    
    % Hash computation, Stage 2 - H(jth) intermediate hash value
    H(j,1,:) = mod_addition(a, flattenlogical(H(i,1,:)));
    H(j,2,:) = mod_addition(b, flattenlogical(H(i,2,:)));
    H(j,3,:) = mod_addition(c, flattenlogical(H(i,3,:)));
    H(j,4,:) = mod_addition(d, flattenlogical(H(i,4,:)));
    H(j,5,:) = mod_addition(e, flattenlogical(H(i,5,:)));
    H(j,6,:) = mod_addition(f, flattenlogical(H(i,6,:)));
    H(j,7,:) = mod_addition(g, flattenlogical(H(i,7,:)));
    H(j,8,:) = mod_addition(h, flattenlogical(H(i,8,:)));
    
    for k=1:8
        H_N{k} = dec2hex(bin2decimal(logical2char(H(j,k,:))),8);
    end
end

digest = strjoin(H_N,'');

end
