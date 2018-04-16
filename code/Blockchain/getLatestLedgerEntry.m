function [ ledger_entry ] = getLatestLedgerEntry( ledger )
%getLatestLedgerEntry() returns the handle to the last ledger class object
%   in the ledger entry.

% Tyson Cross 1239448

ledger_index = numel(ledger);
ledger_entry = ledger(ledger_index);

end

