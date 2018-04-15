classdef Transaction < handle
    %Transaction is a container class for transactional ledger data
    
    % Tyson Cross 1239448
    
	properties (SetAccess = private, GetAccess = private)
        Data % cell array of {'id'[balance]}
	end
	properties %(SetAccess = private, GetAccess = public)
        ID_index
        ID_me
        ID_recipient
        ID_sender
        Transation_amount
        Hash
	end
	methods
        function obj = Transaction(people, id_num)
            %Transaction() contructor, sets the initial financial data
            obj.Data = people;
            obj.ID_index = [1:length(obj.Data)];
            obj.ID_me = obj.Data{id_num,1};
        end
      
        function makeTransfer(obj, amount, sender,recipient)
            if (getBalance(obj,sender)-amount<=0)
                error('Insufficient tokens')
            elseif strcmp(getID(obj,recipient),getID(obj,sender))
                error('Invalid transfer, sender and recipient must be seperate')
            else
                setBalance(obj,amount,sender);
                setBalance(obj,amount,recipient);
                disp(['New Balance is ',num2str(getBalance(obj,sender)), ' tokens'])
                obj.Transation_amount = amount;
                obj.ID_sender = getID(obj,sender);
                obj.ID_recipient = getID(obj,recipient);
            end
        end
         
        function r = getBalance(obj,id)
            r = obj.Data{id,2};
        end
          
        function setBalance(obj,value, id)
            obj.Data{id,2} = obj.Data{id,2} + value;
        end
          
        function r = getSignature(obj,id)
            r = obj.Data{id,1};
        end
        
        function r = getTotalBalance(obj)
            val = 0;
            for i=1:length(obj.Data)
                val = val + obj.Data{i,2};
            end
            r = val;
        end
        
        function removeBySignature(obj,signature)
            [~, pos] = ismember(signature,obj.Data(:,1));
            if pos>0
                disp(['Removing ', obj.Data(pos,:)])
                obj.ID_index(pos) = [];
                obj.Data(pos,:) = [];
            else
                disp('ID not found')
            end
        end
        
            function removeByID(obj,id)
                disp(['Removing ',obj.Data(id,:)])
                obj.ID_index(id) = [];
                obj.Data(id,:) = [];
            end
        
%         function setHash(obj)
%             a = [{char(obj.Data{:})} char{obj.ID_index(:)}]
%             obj.Hash = hash(a(~isspace(a)));
%         end
    end
end




