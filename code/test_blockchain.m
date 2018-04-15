% Tyson Cross 1239448
addpath('SHA256','utilities','Blockchain');
clc; clear all;

% Initialise a basic system of participants
clear participants
num_of_participants = 9;
for i=1:num_of_participants
    id = strcat({'id_'},num2str(i),'.pub');
    participants{i,1} = getSignatures(id{1});
    participants{i,2} = randi([1000 10000]);
end


% create a simple blockchain
ledger = genesisEntry();

% create some transactions
len = length(participants);
sender = randi(len);
reciever = randi(len);
while sender==i || sender==reciever
    sender = randi(len);
end
while reciever==i || reciever==sender
    reciever = randi(len);
end
amount = randi(10);
clear tx1
tx1 = Transaction(participants, sender);
tx1.makeTransfer(amount, sender, reciever);
tx1.getBalance(sender);
tx1.getTotalBalance();

a = tx1.getSignature(7)
tx1.removeBySignature(a);
tx1.removeByID(9);
getSignatures(id{1});




% b = LedgerEntry( 0, '0', datenum(clock), tx1, '15C09AE919850A63F2DA39F05B4773941E7BDF9E360AD118BA894237F6E635A5')


