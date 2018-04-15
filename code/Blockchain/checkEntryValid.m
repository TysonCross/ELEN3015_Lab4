function [ value ] = checkEntryValid( new_entry, last_entry )
%checkEntryValid() checks the latest ledger entry for validity

% Tyson Cross 1239448

people = loadPeople(5);
tx1=Transaction(people,1);

last_entry = LedgerEntry(1,'1',datenum(clock),
if last_entry.getIndex() + 1
    
% var isValidNewBlock = (newBlock, previousBlock) => {
%     if (previousBlock.index + 1 !== newBlock.index) {
%         console.log('invalid index');
%         return false;
%     } else if (previousBlock.hash !== newBlock.previousHash) {
%         console.log('invalid previoushash');
%         return false;
%     } else if (calculateHashForBlock(newBlock) !== newBlock.hash) {
%         console.log('invalid hash: ' + calculateHashForBlock(newBlock) + ' ' + newBlock.hash);
%         return false;
%     }
%     return true;
% };

end

