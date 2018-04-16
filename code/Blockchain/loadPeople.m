function [ participants ] = loadPeople( num_of_participants)
%loadPeople() Creates simple signatures for each participant

if nargin <1
    num_of_participants = 9;
end

for i=1:num_of_participants
    id_val = strcat({'id_'},num2str(i),'.pub');
    if i==1
        participants{i,1} = ['39DF49683542CA728C04AC46C523D602541B25C1A8962E59DB639841CAB6B86A+Person1@Computer1'];
    else
        participants{i,1} = [hash(char(randi(1000))) '+Person', num2str(i),'@Computer',num2str(i)];
    end
    participants{i,2} = randi([1000 10000]);
end

end

