function [discardSubject, discarded] = checkForDiscard(sa, discarded, nTrials, choseDThreshold)
    
    % Include subject unless it fulfills the criteria
    discardSubject = 0;
    
    % If the data is incomplete
    if(length(sa.trial_index) ~= nTrials)
        discarded.incompleteData_n = discarded.incompleteData_n + 1;
        discarded.incompleteData_id = [discarded.incompleteData_id; sa.workerId{1}];
        discardSubject = 1;
        return
    % Else if the subject chose D more than threshold
    else
        [discardSubject, discarded] = check_choseDAboveThreshold(sa, discarded, choseDThreshold);
    end
    
end