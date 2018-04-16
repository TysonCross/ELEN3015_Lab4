function [ LEDGER ] = replaceLedger( new_ledger, current_ledger)
%replaceLedger() Replaces the old ledger with a new ledger, if the length is longer

if isValidLedger(new_ledger) && (length(new_ledger) > length(current_ledger))
    LEDGER = new_ledger;
    disp('New ledger is valid. Replacing old ledger with newly received ledger');
else
    LEDGER = current_ledger;
    disp('Received ledger invalid. Retaining original ledger.');
end

end

