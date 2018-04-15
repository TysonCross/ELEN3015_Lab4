function [genesis_entry] = genesisEntry()

    genesis_entry = LedgerEntry(0, '0', datenum(clock), 'Sic Parvis Magna', '816534932c2b7154836da6afc367695e6337db8a921823784c14378abed4f7d7');
end


