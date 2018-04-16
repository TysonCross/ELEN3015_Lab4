function [genesis_entry] = genesisEntry(data)
%genesisEntry() creates the first entry in the ledger.

% Tyson Cross 1239448

    tx0 = Transaction( data, data{:,1});
    tx0.lock();
    genesis_entry =     LedgerEntry(0, '0', datetime(clock), tx0,...
                        '816534932c2b7154836da6afc367695e6337db8a921823784c14378abed4f7d7');
                    
    disp('Created a new ledger')
    
end


