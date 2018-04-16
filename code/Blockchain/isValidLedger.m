function [ value ] = isValidLedger( ledger )
%isValidLedger() checks the entire ledger for validity

% Tyson Cross 1239448
    val = false;
    
    if ~isequal(ledger(1),genesisEntry())
        val = false;
    else
        for i=2:length(ledger)
            if isEntryValid(ledger(i),ledger(i-1))
                val = true;
            else
                val = false;
                break;
            end
        end
    end
    
    value = val;
    
end

