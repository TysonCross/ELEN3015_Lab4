function C = flatten(A)
C = {};
for i=1:numel(A)  
    if(~iscell(A{i}))
        C = [C,A{i}];
    else
       Ctemp = flatten(A{i});
       C = [C,Ctemp{:}];
    end

end
	C = squeeze(C(:));
    C = C(~isspace(C(:)));
end