% Tyson Cross 1239448
addpath('SHA256','utilities','Blockchain');
clc; clear all;

% create a simple blockchain
lg1 = genesisEntry();
ledger(1) = lg1;            % <- ideally a tree or linked list structure, for now a simple vector array

% Generate a basic system of participants and pre-existing tokens
people = loadPeople(9);
person = people{1:1};       % <- my identity

% Initialise the transaction data, put the availible people and tokens into the ledger
tx2 = Transaction(people, person);
lg2 = createLedgerEntry(tx2,ledger);
if checkEntryValid(lg2, getLatestLedgerEntry(ledger))
    ledger(lg2.Index) = (lg2);
end
% addEntry(lg2, ledger);

% perform a transaction
tx3 = createNewTransactionFromLastRecord(ledger);
[ amount, sender, reciever  ] = randomTransactionParameters(tx3);
tx3.makeTransfer(amount, sender, reciever);
lg3 = createLedgerEntry(tx3,ledger);
if checkEntryValid(lg3, getLatestLedgerEntry(ledger))
    ledger(int64(lg3.Index)) = (lg3);
end







