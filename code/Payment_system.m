% Tyson Cross 1239448
addpath('SHA256','utilities','Blockchain');
clc; clear all;

%% Setup
global LEDGER;

% Generate a basic system of participants and pre-existing tokens
people = loadPeople(9);

% My identity
my_Signature = people{1:1};                 
my_ID = 1;

% create a simple blockchain
% ideally a tree or linked list structure, for now a simple vector array
LEDGER = [genesisEntry()];
disp('Created a new ledger')

disp(' ')
disp('Initialise the transaction data, put the available people and tokens into the ledger...')
tx2 = Transaction(people, my_Signature);
lg2 = createLedgerEntry(tx2,LEDGER);
LEDGER = addEntry(lg2, LEDGER);

%% Output
disp(' ')
disp(' ID                         Signature                                                      Tokens')
disp('-------------------------------------------------------------------------------------------------')
for i=1:numel(people)/2
    disp([' ', num2str(i), '   ', char(people{i,1}), '     ',num2str(people{i,2})])
end
disp('-------------------------------------------------------------------------------------------------')
original_tokens = LEDGER(end).getTransactionData.getTotalBalance;
disp(['Total: ', num2str(original_tokens) ' Tokens'])
clear people tx2;

%% Transactions
disp(' ')
disp('Perform a transaction as another person (for demonstration)...')
tx3 = createNewTransactionFromLastRecord(LEDGER, my_ID);
[ amount, sender, reciever  ] = randomTransactionParameters(tx3);
tx3.alterIdentity(sender);
tx3.makeTransfer(amount, sender, reciever);
lg3 = createLedgerEntry(tx3,LEDGER);
LEDGER = addEntry(lg3, LEDGER);
clear tx3;

%% Attacks
disp(' ')
disp('Attempt to repeat a previous transaction...')
% will fail because of an invalid index check
LEDGER = addEntry(lg3, LEDGER); 

disp(' ')
disp('Attempt to add an invalid entry, favouring Person1@Computer1...')
% transfer 1000 tokens from another person to myself
% will fail because of an authentication check
tx_invalid = createNewTransactionFromLastRecord(LEDGER, my_ID);
tx_invalid.alterIdentity(my_ID);
tx_invalid.makeTransfer(1000, 2, 1);
clear tx_invalid;

disp(' ')
disp('Attempt to transfer more tokens than current balance...')
tx_overspend = createNewTransactionFromLastRecord(LEDGER, my_ID);
tx_overspend.alterIdentity(my_ID);
amount = tx_overspend.getBalance(my_ID) + 1000;
tx_overspend.makeTransfer(amount, my_ID, 2);
clear tx_overspend;

disp(' ')
disp('Attempt to manipulate the token balance...')
tx_cheat = createNewTransactionFromLastRecord(LEDGER, my_ID);
tx_cheat.alterIdentity(my_ID);
amount = tx_cheat.getBalance(my_ID) + 10000;
try tx_cheat.Data(my_ID,2) = amount;
catch 
    disp('The Data property of Transaction is not accessible')
end
clear tx_cheat;

disp(' ')
disp('Attempt to insert an forged transaction into the ledger...')
lg_insert = copy(LEDGER(end));
tx_insert = copy(lg_insert.getTransactionData);
tx_insert.alterIdentity(2);
tx_insert.makeTransfer(10, 2,1);
lg_insert_fake = createLedgerEntry(tx_insert,LEDGER);
try lg_insert.Index =lg_insert_fake.Index;
catch
    disp('Unable to alter the index, most properties of the class are read-only')
end
LEDGER = addEntry(lg_insert, LEDGER);
clear tx_insert lg_insert lg_insert_fake;

disp(' ')
disp('Simple attempt to corrupt the ledger...')
tx_corrupt = createNewTransactionFromLastRecord(LEDGER, randi(9));
lg_corrupt = createLedgerEntry(tx_corrupt,LEDGER);
try LEDGER = addEntry(tx_corrupt, LEDGER);
catch
    if isValidLedger(LEDGER)
        disp('Causes an error, but the ledger is unaffected.')
    else
        disp('The ledger has been corrupted')
    end
end

% Make a fork of the ledger...
ledger_competing = copy(LEDGER);

disp(' ')
disp('Perform some transactions to grow the ledger...')
for i=4:10
    tx_new = createNewTransactionFromLastRecord(LEDGER, my_ID);
    [ amount, sender, reciever  ] = randomTransactionParameters(tx_new);
    tx_new.alterIdentity(sender);
    tx_new.makeTransfer(amount, sender, reciever);
    lg_new = createLedgerEntry(tx_new,LEDGER);
    LEDGER = addEntry(lg_new, LEDGER);
    disp(' ')
end
clear tx_new;

disp(' ')
disp('Attempt to replace the ledger with a shorter, competing ledger...')
LEDGER = replaceLedger(ledger_competing, LEDGER);

disp(' ')
disp('Perform some transactions on the competing ledger...')
for i=4:10
    tx_new = createNewTransactionFromLastRecord(ledger_competing, my_ID);
    [ amount, sender, reciever  ] = randomTransactionParameters(tx_new);
    tx_new.alterIdentity(sender);
    tx_new.makeTransfer(amount, sender, reciever);
    lg_new = createLedgerEntry(tx_new,ledger_competing);
    ledger_competing = addEntry(lg_new, ledger_competing);
    disp(' ')
end
clear tx_new;

disp(' ')
disp('Attempt to replace the ledger with a longer, competing ledger...')
LEDGER = replaceLedger(ledger_competing, LEDGER);

%% Output
disp('')
disp('····················································')
disp(['Total Tokens at initialisation:         ', num2str(original_tokens) ' Tokens'])
disp(['Total Tokens in pool at end of testing: ', num2str(LEDGER(end).getTransactionData.getTotalBalance) ' Tokens'])
disp('····················································')

