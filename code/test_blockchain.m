% Tyson Cross 1239448
addpath('SHA256','utilities','Blockchain');
clc; clear all;

% Generate a basic system of participants and pre-existing tokens
people = loadPeople(9);

% My identity
my_Signature = people{1:1};                 
my_ID = 1;

% create a simple blockchain
% ideally a tree or linked list structure, for now a simple vector array
ledger = [genesisEntry({my_Signature [0]})];            

disp(' ')
disp('Initialise the transaction data, put the available people and tokens into the ledger...')
tx2 = Transaction(people, my_Signature);
lg2 = createLedgerEntry(tx2,ledger);
ledger = addEntry(lg2, ledger);
disp(' ID                         Signature                                                      Tokens')
disp('-------------------------------------------------------------------------------------------------')
for i=1:numel(people)/2
    disp([' ', num2str(i), '   ', char(people{i,1}), '     ',num2str(people{i,2})])
end
disp('-------------------------------------------------------------------------------------------------')
disp(['Total: ', num2str(lg2.getTransactionData.getTotalBalance) ' Tokens'])
clear people tx2;

disp(' ')
disp('Perform a transaction as another person (for demonstration)...')
tx3 = createNewTransactionFromLastRecord(ledger);
[ amount, sender, reciever  ] = randomTransactionParameters(tx3);
tx3.alterIdentity(sender);
tx3.makeTransfer(amount, sender, reciever);
lg3 = createLedgerEntry(tx3,ledger);
ledger = addEntry(lg3, ledger);
clear tx3;

disp(' ')
disp('Attempt to repeat a previous transaction...')
% will fail because of an invalid index check
ledger = addEntry(lg3, ledger); 

disp(' ')
disp('Attempt to add an invalid entry, favouring Person1@Computer1...')
% transfer 1000 tokens from another person to myself
% will fail because of an authentication check
tx_invalid = createNewTransactionFromLastRecord(ledger);
tx_invalid.alterIdentity(my_ID);
tx_invalid.makeTransfer(1000, 2, 1);
clear tx_invalid;

disp(' ')
disp('Attempt to transfer more tokens than current balance...')
tx_overspend = createNewTransactionFromLastRecord(ledger);
tx_overspend.alterIdentity(my_ID);
amount = tx_overspend.getBalance(my_ID) + 1000;
tx_overspend.makeTransfer(amount, my_ID, 2);
clear tx_overspend;

disp(' ')
disp('Attempt to manipulate the token balance...')
tx_cheat = createNewTransactionFromLastRecord(ledger);
tx_cheat.alterIdentity(my_ID);
amount = tx_cheat.getBalance(my_ID) + 10000;
try tx_cheat.Data(my_ID,2) = amount;
catch 
    disp('The Data property of Transaction is not accessible')
end
clear tx_cheat;

% disp(' ')
% disp('Create a competing ledger...')
% ledger_new = copy(ledger);

disp(' ')
disp('Attempt to insert an forged transaction into the ledger...')
lg_insert = copy(ledger(end));
tx_insert = copy(lg_insert.getTransactionData);
tx_insert.alterIdentity(2);
tx_insert.makeTransfer(10, 2,1);
lg_insert_fake = createLedgerEntry(tx_insert,ledger);
try lg_insert.Index =lg_insert_fake.Index;
catch
    disp('Unable to alter the index, most properties of the class are read-only')
end
ledger = addEntry(lg_insert, ledger);
clear tx_insert lg_insert lg_insert_fake;

disp(' ')
disp('Attempt to corrupt the ledger...')
tx_corrupt = createNewTransactionFromLastRecord(ledger);
lg_corrupt = createLedgerEntry(tx_corrupt,ledger);
ledger = addEntry(tx_corrupt, ledger);

disp(' ')
disp('Perform a lot of transactions to grow the ledger...')
for i=5:20
    tx_new = createNewTransactionFromLastRecord(ledger);
    [ amount, sender, reciever  ] = randomTransactionParameters(tx_new);
    tx_new.alterIdentity(sender);
    tx_new.makeTransfer(amount, sender, reciever);
    lg_new = createLedgerEntry(tx_new,ledger);
    ledger = addEntry(lg_new, ledger);
end
clear tx_new;



disp(' ')
disp('Perform a lot of transactions to grow the ledger...')