% Tyson Cross 1239448
clc; clear all;

% prompt = 'Enter something to hash: ';
% str = input(prompt, 's');
% str = ['This is a short message I wish to hash'];
str = ['This is a long message I wish to hash: To Sherlock Holmes she is always the woman.' ...
        'I have seldom heard him mention her under any other name. In his eyes she eclipses '...
        'and predominates the whole of her sex. It was not that he felt any emotion akin to '...
        'love for Irene Adler. All emotions, and that one particularly, were abhorrent to his '...
        'cold, precise but admirably balanced mind. He was, I take it, the most perfect reasoning '...
        'and observing machine that the world has seen, but as a lover he would have placed '...
        'himself in a false position. He never spoke of the softer passions, save with a gibe '...
        'and a sneer. They were admirable things for the observer--excellent for drawing the '...
        'veil from men''s motives and actions. But for the trained reasoner to admit such '...
        'intrusions into his own delicate and finely adjusted temperament was to introduce a '...
        'distracting factor which might throw a doubt upon all his mental results. Grit in a '...
        'sensitive instrument, or a crack in one of his own high-power lenses, would not be '...
        'more disturbing than a strong emotion in a nature such as his. And yet there was but '...
        'one woman to him, and that woman was the late Irene Adler, of dubious and questionable memory.'];
    
% encode
raw_message = dec2bin(uint32(str));
len_message = numel(raw_message);
bin_message = reshape(raw_message,[1 len_message]);

% make the message a multiple of 512, parsed into n blocks of 512 bits
message = reshape(padder(bin_message),[],512);
clear raw_message len_message;


% decode
raw_decoded_msg = reshape(bin_message, [numel(bin_message)/7 7]); % parse for decoding
decoded_msg = char(bin2dec(raw_decoded_msg))';                    % decode into ASCII

clear raw_decoded_msg;

assert(strcmp(str,decoded_msg)==1);

disp(message)
disp(' ')
disp(decoded_msg)

% message = logical(randi(2, [1 len]) - 1)
% getByteStreamFromArray(message)