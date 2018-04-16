function [ ledger_entry ] = createLedgerEntry( transaction, ledger )
%createLedgerEntry() creates a new ledger entry, retrieving the previous ledger entry's data

% Tyson Cross 1239448

previous_ledger_entry = getLatestLedgerEntry(ledger);
next_index = previous_ledger_entry.Index + 1;
next_timestamp = datenum(clock);
next_hash = calculateHash(  next_index,...
                            previous_ledger_entry.Hash,...
                            next_timestamp,...
                            transaction.Hash);
ledger_entry = LedgerEntry(next_index, previous_ledger_entry.Hash, next_timestamp, transaction, next_hash);

end

