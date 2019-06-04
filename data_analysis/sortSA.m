function sa = sortSA(sa)
    
    % Get the sort indices
    [sorted, sortIndex] = sort(sa.trial_index);
    
    % Get the fieldnames
    fn = fieldnames(sa);
    
    % Loop through the sa and sort each field
    for i = 1:numel(fn)
        currentFieldName = fn{i};
        field = sa.(currentFieldName);
        sa.(currentFieldName) = field(sortIndex);
    end
    
end