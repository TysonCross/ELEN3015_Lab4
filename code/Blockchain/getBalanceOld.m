function [ amount ] = getBalanceOLD( people, id )
%getBalance() is a proxy function for a secure retrieval of the current
% balance of coins in the public ledger

amount = people{id}{2};

end

