% Tyson Cross 1239448
addpath('SHA256','utilities','Blockchain');
clc; clear all;

% Initialise a basic system of participants
num_of_participants = 9;
for i=1:num_of_participants
    id_val = strcat({'id_'},num2str(i),'.pub');
    participants{i,1} = getSignatures(id_val{1});
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

tx1 = Transaction(participants, sender);
tx1.makeTransfer(amount, sender, reciever);
tx1.getBalance(sender);
tx1.getTotalBalance();
% tx1.removeBySignature(a);
% tx1.removeByID(9);
tx1.makeTransfer(amount, sender, reciever);
tx1.doesExist(reciever);
tx1.setHash()

% ID_index = [1:9];
% Data = participants;
% ID_me = participants{1,1};
% ID_recipient = participants{1,1};
% ID_sender = participants{1,1};
% Transation_amount = 45;
% Hash = 'abcdefg1234567890987654321afbefgh';
% 
% a = squeeze([char(flatten({char([Data{:,1}]) num2str([Data{:,2}]) [ID_me] [ID_recipient] [ID_sender] num2str(Transation_amount)}))]);
% a=a(~isspace(a(:)));
% hash(a)

% b = LedgerEntry( 0, '0', datenum(clock), tx1, '15C09AE919850A63F2DA39F05B4773941E7BDF9E360AD118BA894237F6E635A5')


