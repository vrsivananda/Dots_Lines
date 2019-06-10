function evidenceData = analyzeEvidence(chosenStimuliData, coherenceData)
    
    % Key
    % norm   = normalized
    % unnorm = unnormalized
    
    % Segments to divide
    segments = 4;
    
    %-------------------------------------------------
    
    % One for dots and one for lines
    for stimuliType = {'Dots', 'Lines'}
        
        % Get the stimuli field
        stimuliField = stimuliType{1};
        
        for e_type = {'norm','unnorm','total','T','furl'}
            
            % Make the sorted structure
            for variable = {'e','correct','conf'}
                % Make the field name
                field = [variable{1} '_' e_type{1}];
                % Preallocate the field as an empty array
                sorted.(stimuliField).(field) = [];
            end
            
            % Make the evidenceData structure
            for variable = {'e','performance','confidence'}
                
                % The statistics field
                for statField = {'mean','sd','se'}
                    % Make the field name
                    field = [variable{1} '_' e_type{1} '_' statField{1}];
                    % Preallocate the field as an empty array
                    evidenceData.(stimuliField).(field) = [];
                end
            end
            
        end
        
    end
    
    %-------------------------------------------------
    
    % One for dots and one for lines
    for stimuliType = {'Dots', 'Lines'}
        
        % Get the stimuli field
        stimuliField = stimuliType{1};
        
        % Allocate for convenience
        T  = coherenceData.(stimuliField).T;
        NT = coherenceData.(stimuliField).NT;
        D  = coherenceData.(stimuliField).D;
        
        % Various definitions of PE
        e_norm = (T-NT)./(T+NT+D);
        e_unnorm = (T-NT);
        e_total = (T+NT+D);
        e_T = T;
        e_furl = (T-NT)./D;
        
        % For loop to sort and order each subject's data
        for i = 1:size(e_norm,2)
            
            % --- Normalized ---
            
            % Sort e, correct and confidence based on e_normalized
            [sorted_e_norm, sort_index_norm] = sort(e_norm(:,i));
            
            correct_col = chosenStimuliData.(stimuliField).correct(:,i);
            sorted_correct_norm = correct_col(sort_index_norm);
            
            conf_col = chosenStimuliData.(stimuliField).confidence(:,i);
            sorted_conf_norm = conf_col(sort_index_norm);
            
            % Append to our structure array
            sorted.(stimuliField).e_norm = [sorted.(stimuliField).e_norm, sorted_e_norm];
            sorted.(stimuliField).correct_norm = [sorted.(stimuliField).correct_norm, sorted_correct_norm];
            sorted.(stimuliField).conf_norm = [sorted.(stimuliField).conf_norm, sorted_conf_norm];
            
            
            % --- Unnormalized ---
            
            % Sort e and correct based on e_unnormalized
            [sorted_e_unnorm, sort_index_unnorm] = sort(e_unnorm(:,i));
            
            correct_col = chosenStimuliData.(stimuliField).correct(:,i);
            sorted_correct_unnorm = correct_col(sort_index_unnorm);
            
            conf_col = chosenStimuliData.(stimuliField).confidence(:,i);
            sorted_conf_unnorm = conf_col(sort_index_unnorm);
            
            % Append to our structure array
            sorted.(stimuliField).e_unnorm = [sorted.(stimuliField).e_unnorm, sorted_e_unnorm];
            sorted.(stimuliField).correct_unnorm = [sorted.(stimuliField).correct_unnorm, sorted_correct_unnorm];
            sorted.(stimuliField).conf_unnorm = [sorted.(stimuliField).conf_unnorm, sorted_conf_unnorm];
            
            % --- Total ---
            
            % Sort e, correct and confidence based on e_total
            [sorted_e_total, sort_index_total] = sort(e_total(:,i));
            
            correct_col = chosenStimuliData.(stimuliField).correct(:,i);
            sorted_correct_total = correct_col(sort_index_total);
            
            conf_col = chosenStimuliData.(stimuliField).confidence(:,i);
            sorted_conf_total = conf_col(sort_index_total);
            
            % Append to our structure array
            sorted.(stimuliField).e_total = [sorted.(stimuliField).e_total, sorted_e_total];
            sorted.(stimuliField).correct_total = [sorted.(stimuliField).correct_total, sorted_correct_total];
            sorted.(stimuliField).conf_total = [sorted.(stimuliField).conf_total, sorted_conf_total];
            
            % --- T ---
            
            % Sort e, correct and confidence based on e_T
            [sorted_e_T, sort_index_T] = sort(e_T(:,i));
            
            correct_col = chosenStimuliData.(stimuliField).correct(:,i);
            sorted_correct_T = correct_col(sort_index_T);
            
            conf_col = chosenStimuliData.(stimuliField).confidence(:,i);
            sorted_conf_T = conf_col(sort_index_T);
            
            % Append to our structure array
            sorted.(stimuliField).e_T = [sorted.(stimuliField).e_T, sorted_e_T];
            sorted.(stimuliField).correct_T = [sorted.(stimuliField).correct_T, sorted_correct_T];
            sorted.(stimuliField).conf_T = [sorted.(stimuliField).conf_T, sorted_conf_T];
            
            % --- Furl ---
            
            % Sort e, correct and confidence based on e_furl
            [sorted_e_furl, sort_index_furl] = sort(e_furl(:,i));
            
            correct_col = chosenStimuliData.(stimuliField).correct(:,i);
            sorted_correct_furl = correct_col(sort_index_furl);
            
            conf_col = chosenStimuliData.(stimuliField).confidence(:,i);
            sorted_conf_furl = conf_col(sort_index_furl);
            
            % Append to our structure array
            sorted.(stimuliField).e_furl = [sorted.(stimuliField).e_furl, sorted_e_furl];
            sorted.(stimuliField).correct_furl = [sorted.(stimuliField).correct_furl, sorted_correct_furl];
            sorted.(stimuliField).conf_furl = [sorted.(stimuliField).conf_furl, sorted_conf_furl];
            
        end
        
    end
    
    %-------------------------------------------------
    
    % One for dots and one for lines
    for stimuliType = {'Dots', 'Lines'}
        
        % Get the stimuli field
        stimuliField = stimuliType{1};
        
        
        % Process the data for performance
        % Go through each subject
        for i = 1:size(e_norm,2)
            
            % Normalized
            
            performance_norm_mean_array = [];
            performance_norm_sd_array = [];
            
            confidence_norm_mean_array = [];
            confidence_norm_sd_array = [];
            
            e_norm_mean_array = [];
            e_norm_sd_array = [];
            
            % Unnormalized
            
            performance_unnorm_mean_array = [];
            performance_unnorm_sd_array = [];
            
            confidence_unnorm_mean_array = [];
            confidence_unnorm_sd_array = [];
            
            e_unnorm_mean_array = [];
            e_unnorm_sd_array = [];
            
            % Total
            
            performance_total_mean_array = [];
            performance_total_sd_array = [];
            
            confidence_total_mean_array = [];
            confidence_total_sd_array = [];
            
            e_total_mean_array = [];
            e_total_sd_array = [];
            
            % T
            
            performance_T_mean_array = [];
            performance_T_sd_array = [];
            
            confidence_T_mean_array = [];
            confidence_T_sd_array = [];
            
            e_T_mean_array = [];
            e_T_sd_array = [];
            
            % Furl
            
            performance_furl_mean_array = [];
            performance_furl_sd_array = [];
            
            confidence_furl_mean_array = [];
            confidence_furl_sd_array = [];
            
            e_furl_mean_array = [];
            e_furl_sd_array = [];
            
            % Get the segment size
            segment_size = size(e_norm,1)/segments;
            
            % Initialize the end index
            end_index = 0;
            
            % For loop that goes through each piece to process (depending on
            % how we want to divide it up)
            for j = 1:segments
                
                % Define the start and end indices
                start_index = end_index + 1;
                end_index = j*(segment_size);
                % Floor the end_index so that it isn't a fraction
                end_index = floor(end_index);
                
                %[delete this!!!] THIS DOES NOT BELONG HERE.
                %if (end_index > length(sorted.(stimuliField).conf_norm))
                %    end_index = length(sorted.(stimuliField).conf_norm);
                %end
                
                
                % --- Normalized ---
                
                % Index out the relevant sections
                conf_norm_section = sorted.(stimuliField).conf_norm(start_index:end_index, i);
                correct_norm_section = sorted.(stimuliField).correct_norm(start_index:end_index, i);
                e_norm_section  = sorted.(stimuliField).e_norm(start_index:end_index, i);
                
                % Calculate the confidence
                confidence_norm_mean_array = [confidence_norm_mean_array; sum(conf_norm_section)/segment_size];
                confidence_norm_sd_array = [confidence_norm_sd_array; std(conf_norm_section)];
                
                % Calculate the performance
                performance_norm_mean_array = [performance_norm_mean_array; sum(correct_norm_section)/segment_size];
                performance_norm_sd_array = [performance_norm_sd_array; std(correct_norm_section)];
                
                % Calculate the e_norm
                e_norm_mean_array = [e_norm_mean_array; mean(e_norm_section)];
                e_norm_sd_array = [e_norm_sd_array; std(e_norm_section)];
                
                
                % --- Unnormalized ---
                
                % Index out the relevant sections
                conf_unnorm_section = sorted.(stimuliField).conf_unnorm(start_index:end_index, i);
                correct_unnorm_section = sorted.(stimuliField).correct_unnorm(start_index:end_index, i);
                e_unnorm_section  = sorted.(stimuliField).e_unnorm(start_index:end_index, i);
                
                % Calculate the confidence
                confidence_unnorm_mean_array = [confidence_unnorm_mean_array; sum(conf_unnorm_section)/segment_size];
                confidence_unnorm_sd_array = [confidence_unnorm_sd_array; std(conf_unnorm_section)];
                
                % Calculate the performance
                performance_unnorm_mean_array = [performance_unnorm_mean_array; sum(correct_unnorm_section)/segment_size];
                performance_unnorm_sd_array = [performance_unnorm_sd_array; std(correct_unnorm_section)];
                
                % Calculate the e_norm
                e_unnorm_mean_array = [e_unnorm_mean_array; mean(e_unnorm_section)];
                e_unnorm_sd_array = [e_unnorm_sd_array; std(e_unnorm_section)];
                
                
                % --- Total ---
                
                % Index out the relevant sections
                conf_total_section = sorted.(stimuliField).conf_total(start_index:end_index, i);
                correct_total_section = sorted.(stimuliField).correct_total(start_index:end_index, i);
                e_total_section  = sorted.(stimuliField).e_total(start_index:end_index, i);
                
                % Calculate the confidence
                confidence_total_mean_array = [confidence_total_mean_array; sum(conf_total_section)/segment_size];
                confidence_total_sd_array = [confidence_total_sd_array; std(conf_total_section)];
                
                % Calculate the performance
                performance_total_mean_array = [performance_total_mean_array; sum(correct_total_section)/segment_size];
                performance_total_sd_array = [performance_total_sd_array; std(correct_total_section)];
                
                % Calculate the e_norm
                e_total_mean_array = [e_total_mean_array; mean(e_total_section)];
                e_total_sd_array = [e_total_sd_array; std(e_total_section)];
                
                
                % --- T ---
                
                % Index out the relevant sections
                conf_T_section = sorted.(stimuliField).conf_T(start_index:end_index, i);
                correct_T_section = sorted.(stimuliField).correct_T(start_index:end_index, i);
                e_T_section  = sorted.(stimuliField).e_T(start_index:end_index, i);
                
                % Calculate the confidence
                confidence_T_mean_array = [confidence_T_mean_array; sum(conf_T_section)/segment_size];
                confidence_T_sd_array = [confidence_T_sd_array; std(conf_T_section)];
                
                % Calculate the performance
                performance_T_mean_array = [performance_T_mean_array; sum(correct_T_section)/segment_size];
                performance_T_sd_array = [performance_T_sd_array; std(correct_T_section)];
                
                % Calculate the e_norm
                e_T_mean_array = [e_T_mean_array; mean(e_T_section)];
                e_T_sd_array = [e_T_sd_array; std(e_T_section)];
                
                
                % --- Furl ---
                
                % Index out the relevant sections
                conf_furl_section = sorted.(stimuliField).conf_furl(start_index:end_index, i);
                correct_furl_section = sorted.(stimuliField).correct_furl(start_index:end_index, i);
                e_furl_section  = sorted.(stimuliField).e_furl(start_index:end_index, i);
                
                % Calculate the confidence
                confidence_furl_mean_array = [confidence_furl_mean_array; sum(conf_furl_section)/segment_size];
                confidence_furl_sd_array = [confidence_furl_sd_array; std(conf_furl_section)];
                
                % Calculate the performance
                performance_furl_mean_array = [performance_furl_mean_array; sum(correct_furl_section)/segment_size];
                performance_furl_sd_array = [performance_furl_sd_array; std(correct_furl_section)];
                
                % Calculate the e_norm
                e_furl_mean_array = [e_furl_mean_array; mean(e_furl_section)];
                e_furl_sd_array = [e_furl_sd_array; std(e_furl_section)];
                
                
            end
            % End of for loop that goes through each segment
            
            % Place this subject's data into the structure array with other
            % subjects data
            
            % --- Normalized ---
            evidenceData.(stimuliField).performance_norm_mean = [evidenceData.(stimuliField).performance_norm_mean, performance_norm_mean_array];
            evidenceData.(stimuliField).performance_norm_sd   = [evidenceData.(stimuliField).performance_norm_sd,   performance_norm_sd_array];
            evidenceData.(stimuliField).performance_norm_se   = evidenceData.(stimuliField).performance_norm_sd./sqrt(segment_size);
            
            evidenceData.(stimuliField).confidence_norm_mean = [evidenceData.(stimuliField).confidence_norm_mean, confidence_norm_mean_array];
            evidenceData.(stimuliField).confidence_norm_sd   = [evidenceData.(stimuliField).confidence_norm_sd,   confidence_norm_sd_array];
            evidenceData.(stimuliField).confidence_norm_se   = evidenceData.(stimuliField).confidence_norm_sd./sqrt(segment_size);
            
            evidenceData.(stimuliField).e_norm_mean           = [evidenceData.(stimuliField).e_norm_mean, e_norm_mean_array];
            evidenceData.(stimuliField).e_norm_sd             = [evidenceData.(stimuliField).e_norm_sd,   e_norm_sd_array];
            evidenceData.(stimuliField).e_norm_se             = evidenceData.(stimuliField).e_norm_sd./sqrt(segment_size);
            
            % --- Unnormalized ---
            evidenceData.(stimuliField).performance_unnorm_mean = [evidenceData.(stimuliField).performance_unnorm_mean, performance_unnorm_mean_array];
            evidenceData.(stimuliField).performance_unnorm_sd   = [evidenceData.(stimuliField).performance_unnorm_sd,   performance_unnorm_sd_array];
            evidenceData.(stimuliField).performance_unnorm_se   = evidenceData.(stimuliField).performance_unnorm_sd./sqrt(segment_size);
            
            evidenceData.(stimuliField).confidence_unnorm_mean = [evidenceData.(stimuliField).confidence_unnorm_mean, confidence_unnorm_mean_array];
            evidenceData.(stimuliField).confidence_unnorm_sd   = [evidenceData.(stimuliField).confidence_unnorm_sd,   confidence_unnorm_sd_array];
            evidenceData.(stimuliField).confidence_unnorm_se   = evidenceData.(stimuliField).confidence_unnorm_sd./sqrt(segment_size);
            
            evidenceData.(stimuliField).e_unnorm_mean           = [evidenceData.(stimuliField).e_unnorm_mean, e_unnorm_mean_array];
            evidenceData.(stimuliField).e_unnorm_sd             = [evidenceData.(stimuliField).e_unnorm_sd,   e_unnorm_sd_array];
            evidenceData.(stimuliField).e_unnorm_se             = evidenceData.(stimuliField).e_unnorm_sd./sqrt(segment_size);
            
            % --- Total ---
            evidenceData.(stimuliField).performance_total_mean = [evidenceData.(stimuliField).performance_total_mean, performance_total_mean_array];
            evidenceData.(stimuliField).performance_total_sd   = [evidenceData.(stimuliField).performance_total_sd,   performance_total_sd_array];
            evidenceData.(stimuliField).performance_total_se   = evidenceData.(stimuliField).performance_total_sd./sqrt(segment_size);
            
            evidenceData.(stimuliField).confidence_total_mean = [evidenceData.(stimuliField).confidence_total_mean, confidence_total_mean_array];
            evidenceData.(stimuliField).confidence_total_sd   = [evidenceData.(stimuliField).confidence_total_sd,   confidence_total_sd_array];
            evidenceData.(stimuliField).confidence_total_se   = evidenceData.(stimuliField).confidence_total_sd./sqrt(segment_size);
            
            evidenceData.(stimuliField).e_total_mean           = [evidenceData.(stimuliField).e_total_mean, e_total_mean_array];
            evidenceData.(stimuliField).e_total_sd             = [evidenceData.(stimuliField).e_total_sd,   e_total_sd_array];
            evidenceData.(stimuliField).e_total_se             = evidenceData.(stimuliField).e_total_sd./sqrt(segment_size);
            
            % --- T ---
            evidenceData.(stimuliField).performance_T_mean = [evidenceData.(stimuliField).performance_T_mean, performance_T_mean_array];
            evidenceData.(stimuliField).performance_T_sd   = [evidenceData.(stimuliField).performance_T_sd,   performance_T_sd_array];
            evidenceData.(stimuliField).performance_T_se   = evidenceData.(stimuliField).performance_T_sd./sqrt(segment_size);
            
            evidenceData.(stimuliField).confidence_T_mean = [evidenceData.(stimuliField).confidence_T_mean, confidence_T_mean_array];
            evidenceData.(stimuliField).confidence_T_sd   = [evidenceData.(stimuliField).confidence_T_sd,   confidence_T_sd_array];
            evidenceData.(stimuliField).confidence_T_se   = evidenceData.(stimuliField).confidence_T_sd./sqrt(segment_size);
            
            evidenceData.(stimuliField).e_T_mean           = [evidenceData.(stimuliField).e_T_mean, e_T_mean_array];
            evidenceData.(stimuliField).e_T_sd             = [evidenceData.(stimuliField).e_T_sd,   e_T_sd_array];
            evidenceData.(stimuliField).e_T_se             = evidenceData.(stimuliField).e_T_sd./sqrt(segment_size);
            
            % --- Furl ---
            evidenceData.(stimuliField).performance_furl_mean = [evidenceData.(stimuliField).performance_furl_mean, performance_furl_mean_array];
            evidenceData.(stimuliField).performance_furl_sd   = [evidenceData.(stimuliField).performance_furl_sd,   performance_furl_sd_array];
            evidenceData.(stimuliField).performance_furl_se   = evidenceData.(stimuliField).performance_furl_sd./sqrt(segment_size);
            
            evidenceData.(stimuliField).confidence_furl_mean = [evidenceData.(stimuliField).confidence_furl_mean, confidence_furl_mean_array];
            evidenceData.(stimuliField).confidence_furl_sd   = [evidenceData.(stimuliField).confidence_furl_sd,   confidence_furl_sd_array];
            evidenceData.(stimuliField).confidence_furl_se   = evidenceData.(stimuliField).confidence_furl_sd./sqrt(segment_size);
            
            evidenceData.(stimuliField).e_furl_mean           = [evidenceData.(stimuliField).e_furl_mean, e_furl_mean_array];
            evidenceData.(stimuliField).e_furl_sd             = [evidenceData.(stimuliField).e_furl_sd,   e_furl_sd_array];
            evidenceData.(stimuliField).e_furl_se             = evidenceData.(stimuliField).e_furl_sd./sqrt(segment_size);
            
        end
        
    end
    
    
end