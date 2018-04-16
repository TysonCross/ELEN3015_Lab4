function [ amount, sender, reciever  ] = randomTransactionParameters( transaction )
%randomTransactionParameters() sets up a random transfer of tokens

N = numel(transaction.ID_index);
sender = randi(N);
reciever = randi(N);
while sender==reciever
    sender = randi(N);
end
while reciever==sender
    reciever = randi(N);
end
amount = randi(10);

end

