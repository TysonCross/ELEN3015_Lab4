function [ participants ] = loadPeople( num_of_participants)
%UNTITLED16 Summary of this function goes here
%   Detailed explanation goes here

if nargin <1
    num_of_participants = 9;
end

for i=1:num_of_participants
    id_val = strcat({'id_'},num2str(i),'.pub');
    participants{i,1} = [hash(char(randi(1000))) '+Person', num2str(i),'@Computer',num2str(i)];
    participants{i,2} = randi([1000 10000]);
end

end

