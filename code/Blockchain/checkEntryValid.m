function [ value ] = checkEntryValid( new_entry, last_entry )
%checkEntryValid() checks the latest ledger entry for validity

% Tyson Cross 1239448

value = false;
if new_entry.Index ~= last_entry.Index()+1
    disp('Invalid chain, index is not consistent')
elseif new_entry.PreviousHash ~= last_entry.Hash
    disp('Invalid chain, hash values do not match')
elseif calculateEntryHash(new_entry) ~= new_entry.Hash
    disp('Invalid hash!')
else
    value = true;
end

end

