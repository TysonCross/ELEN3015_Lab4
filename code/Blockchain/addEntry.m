function addEntry( new_entry, ledger )
%addEntry() adds a new entry to the ledger

% Tyson Cross 1239448

if checkEntryValid(new_entry, getLatestLedgerEntry(ledger))
    ledger(new_entry.Index) = (new_entry);
end

end

