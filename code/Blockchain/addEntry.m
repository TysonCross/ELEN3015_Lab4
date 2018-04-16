function [ ledger ] = addEntry( new_entry, ledger )
%addEntry() adds a new entry to the ledger

% Tyson Cross 1239448

if isEntryValid(new_entry, getLatestLedgerEntry(ledger))
    ledger = [ledger new_entry];
    ledger(end).getTransactionData().lock();
end

end