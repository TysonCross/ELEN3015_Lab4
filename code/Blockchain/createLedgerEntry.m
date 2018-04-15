function [ block ] = createLedgerEntry( data )
%createLedgerEntry() creates a new ledger entry, retrieving the previous ledger entry's data

% Tyson Cross 1239448

previous_block = getLatestLedgerEntry();
next_index = previous_ledger_entry.Index + 1;
next_timestamp = datenum(clock);
next_hash = hash([next_index, previous_ledger_entry.Hash, next_timestamp, data]);
ledger_entry = LedgerEntry(next_index, previous_ledger_entry.Hash, next_timestamp, data, next_hash);
end

