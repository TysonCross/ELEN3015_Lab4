% Tyson Cross 1239448
addpath('SHA256','utilities','Blockchain');
clc; clear all;

% Generate a basic system of participants and pre-existing tokens
people = loadPeople(9);

% create a simple blockchain
ledger = genesisEntry();


% set up a random transaction
len = length(people);
sender = randi(len);
reciever = randi(len);
while sender==i || sender==reciever
    sender = randi(len);
end
while reciever==i || reciever==sender
    reciever = randi(len);
end
amount = randi(10);

% perform a transaction
tx1 = Transaction(people, sender);
tx1.makeTransfer(amount, sender, reciever);
tx1.getTotalBalance();

new_entry = LedgerEntry( 0, '0', datenum(clock), tx1, '15C09AE919850A63F2DA39F05B4773941E7BDF9E360AD118BA894237F6E635A5')


