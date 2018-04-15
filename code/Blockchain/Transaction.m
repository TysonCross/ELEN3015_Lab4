classdef Transaction < handle
    %Transaction is a container class for transactional ledger data
    
    % Tyson Cross 1239448
    
	properties (SetAccess = private, GetAccess = private)
        Data
	end
	properties (SetAccess = private, GetAccess = public)
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
            setHash(obj);
        end
      
        function makeTransfer(obj, amount, sender,recipient)
            %makeTransfer() makes a transaction between participants
            if ~doesExist(obj,sender) || ~doesExist(obj,recipient)
                error('Invalid ID')
            elseif (getBalance(obj,sender)-amount<=0)
                error('Insufficient tokens')
            elseif strcmp(getSignature(obj,recipient),getSignature(obj,sender))
                error('Invalid transfer, sender and recipient must be seperate')
            else
                setBalance(obj,-amount,sender);
                setBalance(obj,amount,recipient);
                disp(['Transfered ' , num2str(amount), ' tokens to ', getSignature(obj,recipient)]);
                disp(['New Balance is ',num2str(getBalance(obj,sender)), ' tokens'])
                obj.Transation_amount = amount;
                obj.ID_sender = getSignature(obj,sender);
                obj.ID_recipient = getSignature(obj,recipient);
                setHash(obj);
            end
        end
         
        function r = getBalance(obj,id)
            r = obj.Data{id,2};
        end
          
        function setBalance(obj,value, id)
            obj.Data{id,2} = obj.Data{id,2} + value;
            setHash(obj);
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
                setHash(obj);
            else
                disp('ID not found')
            end
        end
        
        function removeByID(obj,id)
            if doesExist(id)
                disp(['Removing ',obj.Data(id,:)])
                obj.ID_index(id) = [];
                obj.Data(id,:) = [];
                setHash(obj);    
            else
                disp('ID not found')
            
            end
        end

        function r = doesExist(obj,id)
            if ismember(id,obj.ID_index)>0
                r = true;
            else
                r = false;
            end
        end
            
        function setHash(obj)
            a = squeeze([char(flatten({char([obj.Data{:,1}]) num2str([obj.Data{:,2}]) [obj.ID_me]...
                [obj.ID_recipient] [obj.ID_sender] num2str(obj.Transation_amount)}))]);
            a = char(a(~isspace(a(:))));
            obj.Hash = hash(a')
        end
    end

end




