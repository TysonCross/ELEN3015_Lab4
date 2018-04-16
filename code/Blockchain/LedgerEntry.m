classdef LedgerEntry < matlab.mixin.Copyable %handle
    %LedgerEntry is a class for ledger entry objects, an individual entry in a simple
    %   blockchain of hash-signed transactional records.
    
    % Tyson Cross 1239448
    
	properties (SetAccess = private, GetAccess = private)
        TransactionData
    end
    properties (SetAccess = private, GetAccess = public)
        Index
        PreviousHash
        Timestamp
        Hash
    end
    methods
        function obj = LedgerEntry(index, previousHash, timestamp, data, hash)
        %LedgerEntry() contructor, creates the ledger entry
            obj.Index = index;
            obj.PreviousHash = previousHash;
            obj.Timestamp = timestamp;
            obj.TransactionData = data;
            obj.Hash = hash;
        end
        function r = getTransactionData(obj)
            r = obj.TransactionData;
        end
    end
end

