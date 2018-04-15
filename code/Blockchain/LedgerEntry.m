classdef LedgerEntry
    %LedgerEntry Summary of this class goes here
    %   Detailed explanation goes here
   properties
        Index
   end
   properties (SetAccess = private, GetAccess = public)
        PreviousHash
        Timestamp
        Data
        Hash
   end
   methods
      function obj = LedgerEntry(index, previousHash, timestamp, data, hash)
         obj.Index = index;
         obj.PreviousHash = previousHash;
         obj.Timestamp = timestamp;
         obj.Data = data;
         obj.Hash = hash;
         end
   end
end

