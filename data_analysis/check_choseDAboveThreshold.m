function [discardSubject, discarded] = check_choseDAboveThreshold(sa, discarded, choseDThreshold)
    
    % Get the number of trials where subjects chose D
    n_choseDistractor = length(...
        returnIndicesIntersect(sa.stimuliChosen, 'D'));
    
    % Get all 3 AFC trials
    n_3AFCTrials = length(returnIndicesIntersect(sa.trialType, 'actual_RDK')) + ...
        length(returnIndicesIntersect(sa.trialType, 'actual_Lines'));
    
    % Get the percent chosen distractor
    percent_chosenDistractor = n_choseDistractor/n_3AFCTrials;
    
    % If it was below threshold, then we return true. Return false
    % otherwise
    if(percent_chosenDistractor < choseDThreshold)
        discardSubject = 0;
    else
        discarded.choseDAboveThreshold_n = discarded.choseDAboveThreshold_n + 1;
        discarded.choseDAboveThreshold_id = [discarded.choseDAboveThreshold_id; sa.workerId{1}];
        discarded.percent_choseDistractor = [discarded.percent_choseDistractor; percent_chosenDistractor];
        discardSubject = 1;
    end
    
end % End of function