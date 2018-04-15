% Tyson Cross 1239448

clc; clear all;

message = [ 'And above all, watch with glittering eyes the whole world around you '...
            'because the greatest secrets are always hidden in the most unlikely '...
            'places. Those who don''t believe in magic will never find it.'];
        
hash_value = hash(message);
disp(hash_value)

clear message;