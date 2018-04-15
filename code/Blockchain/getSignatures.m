function [ id ] = getSignatures( filename )
%getSignatures() reads a public SSH signature for an ID

if nargin<1
    filename = 'example_id.pub';
end

id = fileread(filename);    

end

