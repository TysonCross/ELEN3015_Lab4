classdef Transaction < matlab.mixin.Copyable
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
        Transaction_amount
        Hash
    end
    properties (NonCopyable)
        Locked = false;
    end
	methods
        function obj = Transaction(data, signature)
            %Transaction() contructor, sets the initial financial data
            obj.Data = data;
            obj.ID_index = [1:numel(obj.Data)/2];
            if isAMember(obj, signature) 
                obj.ID_me = signature;
                setHash(obj);
                obj.Locked = false;
            end
        end
      
        function makeTransfer(obj, amount, sender,recipient)
            %makeTransfer() makes a transaction between participants
            if obj.Locked
                error('This transaction is already completed')
            elseif ~doesExist(obj,sender) || ~doesExist(obj,recipient)
                disp('Invalid ID')
            elseif (getBalance(obj,sender)-amount<=0)
                disp('Insufficient tokens')
            elseif ~isAMember(obj, getSignature(obj,sender))
                disp('Not a participant, sorry');
            elseif ~authenticateByID(obj, sender)
                disp('Authentication failure')
            elseif strcmp(getSignature(obj,recipient),getSignature(obj,sender))
                disp('Invalid transfer, sender and recipient must be seperate')
            else
                obj.ID_me = getSignature(obj,sender);
                disp(['Your balance before transfer was ',num2str(getBalance(obj,sender)), ' tokens']);
                setBalance(obj,-amount,sender);
                setBalance(obj,amount,recipient);
                disp(['Transfered ' , num2str(amount), ' tokens to ', getSignature(obj,recipient)]);
                disp(['Your new balance is ', num2str(getBalance(obj,sender)), ' tokens']);
                obj.Transaction_amount = amount;
                obj.ID_sender = getSignature(obj,sender);
                obj.ID_recipient = getSignature(obj,recipient);
                setHash(obj);
                disp(['Transaction completed. (ID: ', obj.Hash, ')']);
                obj.lock();
            end
        end
         
        function r = getBalance(obj,id)
            r = obj.Data{id,2};
        end
          
        function setBalance(obj,value, id)  
            if obj.Locked
                error('This transaction is already completed')
            else
                obj.Data{id,2} = obj.Data{id,2} + value;
                setHash(obj);
            end
        end
          
        function r = getSignature(obj,id)                      % retrieve hash of private key
            r = obj.Data{id,1};
        end
        
        function r = getTotalBalance(obj)                       % total token in system
            val = 0;
            for i=1:length(obj.Data)
                val = val + obj.Data{i,2};
            end
            r = val;
        end

        function r = isAMember(obj, signature)
            if ismember(signature,{obj.Data{:,1}})>0
                r = true;
            else
                r = false;
            end
        end
        
        function r = doesExist(obj,id)
            if ismember(id,obj.ID_index)>0
                r = true;
            else
                r = false;
            end
        end
            
        function setHash(obj)                                   % sets hash of transaction (for ledger hashing)
            if obj.Locked
                error('This transaction is already completed')
            else
                a = strcat(...
                    [char(obj.Data{:,1})],...
                    [char(obj.Data{:,2})],...
                    [char(obj.ID_me)],...
                    [char(obj.ID_recipient)],...
                    [char(obj.ID_sender)],...
                    [num2str(obj.Transaction_amount) ]);

                a = a(~isspace(a(:)));
                obj.Hash = hash(a);
            end
        end
        
        function r = authenticateByID(obj, id)                  % simulates comparing private key hash (by ID)
            if ~strcmp(getSignature(obj,id),obj.ID_me)
                r = false;
            else r = true;
            end
        end
        
        function r = authenticateBySignature(obj, signature)    % simulates comparing private key hash
            if ~strcmp(signature,obj.ID_me)
                r = false;
            else r = true;
            end
        end
        
        function lock(obj)
            obj.Locked = true;
        end
%     end
    
%     methods (Access = protected)
        function alterIdentity(obj, id)                         % Demo function to change ID to be an attacker
            obj.ID_me = getSignature(obj,id);
            setHash(obj);
        end

        function removeByID(obj,id)                             % for bad nodes
            if doesExist(id) && authenticateByID(obj,signature)
                disp(['Removing ',obj.Data(id,:)])
                obj.ID_index(id) = [];
                obj.Data(id,:) = [];
                setHash(obj);    
            else
                disp('ID not found')

            end
        end
        
        function removeBySignature(obj,signature)               % for bad nodes
            [~, pos] = ismember(signature,obj.Data(:,1));
            if pos>0 && authenticateBySignature(obj,signature)
                    disp(['Removing ', obj.Data(pos,:)])
                    obj.ID_index(pos) = [];
                    obj.Data(pos,:) = [];
                    setHash(obj);
            else
                disp('ID not found')
            end
        end
        
    end

end




