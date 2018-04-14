% Tyson Cross 1239448

clc; clear all;

% prompt = 'Enter something to hash: ';
% message = input(prompt, 's');
% message = ['This is a short message I wish to hash'];
message = [ 'And above all, watch with glittering eyes the whole world around you '...
            'because the greatest secrets are always hidden in the most unlikely '...
            'places. Those who don''t believe in magic will never find it.'];
len = length(message);

[ H M ] = hash(message);

% check the data is being correctly processed
decoded_msg = logical2str(M);                                   % decode into ASCII
disp(decoded_msg);


