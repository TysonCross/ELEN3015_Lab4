function [ new_transaction ] = createNewTransactionFromLastRecord( ledger )
%createTransaction retrieves the record of the last transaction

temp = getLatestLedgerEntry( ledger );
new_transaction = temp.getTransactionData;

end

