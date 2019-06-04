function bonus = checkForBonus(subjectId, sa, discardSubject, bonus)
    
    % Check if we discard the subject or we continue to get the number
    % correct
    if (discardSubject)
        ca =  {subjectId, 'discard', 0};
    else
        % Get the amount correct (Done in this way because the row orders might
        % change in the database)
        nCorrect = length(returnIndicesIntersect(sa.trialType, 'actual_RDK',...
            sa.stimuliChosen, 'T')) + ...
            length(returnIndicesIntersect(sa.trialType, 'actual_Lines',...
            sa.stimuliChosen, 'T'));
        
        % Get the previous nCorrect
        prev_nCorrect = bonus{end,2};
        
        % Check to see if the nCorrect is larger than the previous nCorrect
        if(strcmp(prev_nCorrect,'nCorrect') || strcmp(prev_nCorrect,'discard') || nCorrect > prev_nCorrect)
            bonusing = 1;
        elseif(nCorrect <= prev_nCorrect)
            bonusing = 0;
        else
            alert('Something wrong here in checkForBonus');
        end
        
        % Prep cell array for this subject
        ca =  {subjectId, nCorrect, bonusing};
    end
    
    % Add into the bonus cell array matrix
    bonus = [bonus; ca];
    
end