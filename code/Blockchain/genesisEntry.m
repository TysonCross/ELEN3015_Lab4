function [genesis_entry] = genesisEntry()
%genesisEntry() creates the first entry in the ledger.

% Tyson Cross 1239448

    tx0 = Transaction({ '39DF49683542CA728C04AC46C523D602541B25C1A8962E59DB639841CAB6B86A+Person1@Computer1' [0]},...
                        '39DF49683542CA728C04AC46C523D602541B25C1A8962E59DB639841CAB6B86A+Person1@Computer1');
    genesis_entry =     LedgerEntry(0, '0', datenum(clock), tx0,...
                        '816534932c2b7154836da6afc367695e6337db8a921823784c14378abed4f7d7');
    
end


