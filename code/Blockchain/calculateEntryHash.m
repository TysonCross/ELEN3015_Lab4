function [ hash_value ] = calculateEntryHash( entry )
%calculateHash() is a wrapper for the SHA-256 hash function to calculate ledger entries' hashes

% Tyson Cross 1239448

hash_value = calculateHash( entry.Index, entry.PreviousHash, datenum(entry.Timestamp), entry.getTransactionData().Hash );

end

