function [ hash_value ] = calculateHash( index, previous_hash, timestamp, datahash )
%calculateHash calculates the hash of a new leger entry using an implementation of SHA-256

a = [char(num2str(index)), ...
    [char(previous_hash)], ...
    [char(datetime(datenum(timestamp),'ConvertFrom','datenum'))], ...
    [char(datahash)] ];

a = char(a(~isspace(a(:))));

hash_value = hash(a);

end

