function chosenStimuliData = getChosenStimuliData(sa, chosenStimuliData)
    
    for trialType = {'actual_RDK', 'actual_Lines'}
        
        % Convert from cell array to string
        trialType = trialType{1};
        
        % Get the indices of the relevant stimuli
        indices = returnIndicesIntersect(sa.trialType, trialType);
        
        % Use the correct stimuli
        if(strcmp(trialType, 'actual_RDK'))
            stimuli = 'Dots';
        elseif(strcmp(trialType, 'actual_Lines'))
            stimuli = 'Lines';
        end
        
        % Get the coherence data and add them to the matrix
        chosenStimuliData.(stimuli).correct  = [chosenStimuliData.(stimuli).correct,  sa.correct(indices)];
        chosenStimuliData.(stimuli).confidence  = [chosenStimuliData.(stimuli).confidence,  sa.response(indices+1)];
        
    end
    
end