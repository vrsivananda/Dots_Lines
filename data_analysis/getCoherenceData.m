function coherenceData = getCoherenceData(sa, coherenceData)
    
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
        coherenceData.(stimuli).T  = [coherenceData.(stimuli).T,  sa.coh_T(indices)];
        coherenceData.(stimuli).NT = [coherenceData.(stimuli).NT, sa.coh_NT(indices)];
        coherenceData.(stimuli).D  = [coherenceData.(stimuli).D,  sa.coh_D(indices)];
        
    end
    
    
end