% Tyson Cross 1239448
addpath('SHA256','utilities','Blockchain');
clc; clear all;

% create a simple blockchain
ledger = [genesisEntry()];            % ideally a tree or linked list structure, for now a simple vector array

% Generate a basic system of participants and pre-existing tokens
people = loadPeople(9);

% My identity
my_Signature = people{1:1};                 
my_ID = 1;

% Initialise the transaction data, put the availible people and tokens into the ledger
tx2 = Transaction(people, my_Signature);
lg2 = createLedgerEntry(tx2,ledger);
ledger = addEntry(lg2, ledger);

% perform a transaction as another person (for demonstration)
tx3 = createNewTransactionFromLastRecord(ledger);
[ amount, sender, reciever  ] = randomTransactionParameters(tx3);
tx3.alterIdentity(sender);
tx3.makeTransfer(amount, sender, reciever);
lg3 = createLedgerEntry(tx3,ledger);
ledger = addEntry(lg3, ledger);

% attempt to repeat a previous transaction
% will fail because of an invalid index  check
ledger = addEntry(lg3, ledger); 

% attempt to add an invalid entry, favouring Person1@Computer1
% transfer 1000 tokens from another person to myself
% will fail because of an authentication check
tx_invalid = createNewTransactionFromLastRecord(ledger);
tx_invalid.alterIdentity(my_ID);
tx_invalid.makeTransfer(1000, 2, 1);
tx_invalid.delete; % cleanup

% attempt to create a new blockchain
% ledger_invalid = ledger;
% tx_invalid.makeTransfer(1000, 1, 2);  % <- transfer 1000 tokens from myself to another person

