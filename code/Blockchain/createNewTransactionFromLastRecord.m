function [ new_transaction ] = createNewTransactionFromLastRecord( ledger, id)
%createTransaction retrieves the record of the last transaction

temp = getLatestLedgerEntry( ledger );
new_transaction = copy(temp.getTransactionData);
new_transaction.alterIdentity(id);

end

