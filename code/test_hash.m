% Tyson Cross 1239448

clc; clear all;

message = [ 'And above all, watch with glittering eyes the whole world around you '...
            'because the greatest secrets are always hidden in the most unlikely '...
            'places. Those who don''t believe in magic will never find it. '];

total_time = 0;
len = numel(message);
fprintf('Hashing... \n')

for i=1:len;
    tic;
    message = message(1:end-1);
    fprintf('%s\n',message)
    hash_value(i,:) = hash(message);
    t = toc;
    total_time = total_time + t;
    assert(length(hash_value(i,:))==64)
    if i > 1
        dif_hash(i,:) = (hash_value(i,:) == hash_value(i-1,:));
    end
end

clc;
fprintf('Hash values: \n')
disp(hash_value)
fprintf('Collision Map: \n')
for i=1:length(dif_hash)
    disp(logical2char(dif_hash(i,:)))
end

% I = mat2gray(dif_hash)
% rez = get(groot,'ScreenSize');
% figure('Position',[rez(4)/2 rez(3)/2 rez(3)/4 rez(4)/2])
% imshow(I,'InitialMagnification','fit');

disp(['Average time to hash: ', num2str(total_time/len)]);
disp(['Average bit-wise sequential collision probability: ', num2str(sum(sum(dif_hash))/numel(dif_hash))]);

clear message;
