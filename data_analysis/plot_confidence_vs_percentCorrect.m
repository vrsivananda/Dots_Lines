function plot_confidence_vs_percentCorrect(evidenceData, saveFigure)
    
    % Axis limits
    conf_limit_y = [0,100];
    
    % Gradient for colors
    color_gradient = [128, 255,   0; ...
        255, 255,   0; ...
        255, 128,   0; ...
        255,   0,   0];
    color_gradient = color_gradient./255;
    
    % Legend
    legendText = {'Low','Low-Med', 'Med-High', 'High'};
    
    % One for dots and one for lines
    for stimuliType = {'Dots', 'Lines'}
        
        % Get the stimuli field
        stimuliField = stimuliType{1};
        
        % Load in the variables for easy handling
        perf_norm_mean = evidenceData.(stimuliField).performance_norm_mean;
        conf_norm_mean = evidenceData.(stimuliField).confidence_norm_mean;
        
        perf_unnorm_mean = evidenceData.(stimuliField).performance_unnorm_mean;
        conf_unnorm_mean = evidenceData.(stimuliField).confidence_unnorm_mean;
        
        perf_total_mean = evidenceData.(stimuliField).performance_total_mean;
        conf_total_mean = evidenceData.(stimuliField).confidence_total_mean;
        
        perf_T_mean = evidenceData.(stimuliField).performance_T_mean;
        conf_T_mean = evidenceData.(stimuliField).confidence_T_mean;
        
        perf_furl_mean = evidenceData.(stimuliField).performance_furl_mean;
        conf_furl_mean = evidenceData.(stimuliField).confidence_furl_mean;
        
        % Get numbers
        n_subjects = size(perf_norm_mean, 2);
        n_conditions = size(perf_norm_mean, 1);
        
        % ---------- Normalized ----------
        
        figure;
        
        % Go through each condition
        for i = 1:n_conditions
            
            % Color
            color = color_gradient(i,:);
            
            x_mean = perf_norm_mean(i,:);
            y_mean = conf_norm_mean(i,:);
            
            scatter(x_mean, y_mean, 'MarkerEdgeColor', color, 'Marker', 'o', 'MarkerFaceColor', color);
            
            hold on;
            
        end
        % End of performance plot for loop
        
        % Format graph
        title(['Confidence vs. Performance [' stimuliField '] (Normalized Evidence) (n = ' num2str(n_subjects) ')']);
        ylabel('confidence', 'Interpreter', 'none');
        xlabel('% Correct');
        ylim(conf_limit_y);
        xlim([0, 1]);
        % Legend
        legend(legendText, 'Location', 'southwest');
        legend show;
        
        
        
        % ------ Saving ------
        
        % Only save the figure if we want to
        if(saveFigure)
            
            % Create the file name and path to save
            savingFileName = ['conf_vs_perf_[' stimuliField '](e_norm).jpg'];
            savingFilePath = [pwd '/Figures/Overall/' savingFileName];
            
            % Save the data
            saveas(gcf,savingFilePath);
            
        end
        
        
        % ---------- Unnormalized ----------
        
        figure;
        
        % Go through each condition
        for i = 1:n_conditions
            
            % Color
            color = color_gradient(i,:);
            
            x_mean = perf_unnorm_mean(i,:);
            y_mean = conf_unnorm_mean(i,:);
            
            scatter(x_mean, y_mean, 'MarkerEdgeColor', color, 'Marker', 'o', 'MarkerFaceColor', color);
            
            hold on;
            
        end
        % End of performance plot for loop
        
        % Format graph
        title(['Confidence vs. Performance [' stimuliField '] (Unnormalized Evidence) (n = ' num2str(n_subjects) ')']);
        ylabel('confidence', 'Interpreter', 'none');
        xlabel('% Correct');
        ylim(conf_limit_y);
        xlim([0, 1]);
        % Legend
        legend(legendText, 'Location', 'southwest');
        legend show;
        
        
        % ------ Saving ------
        
        % Only save the figure if we want to
        if(saveFigure)
            
            % Create the file name and path to save
            savingFileName = ['conf_vs_perf_[' stimuliField '](e_unnorm).jpg'];
            savingFilePath = [pwd '/Figures/Overall/' savingFileName];
            
            % Save the data
            saveas(gcf,savingFilePath);
            
        end
        
        
        % ---------- Total ----------
        
        figure;
        
        % Go through each condition
        for i = 1:n_conditions
            
            % Color
            color = color_gradient(i,:);
            
            x_mean = perf_total_mean(i,:);
            y_mean = conf_total_mean(i,:);
            
            scatter(x_mean, y_mean, 'MarkerEdgeColor', color, 'Marker', 'o', 'MarkerFaceColor', color);
            
            hold on;
            
        end
        % End of performance plot for loop
        
        % Format graph
        title(['Confidence vs. Performance [' stimuliField '] (Total Evidence (T+N+D)) (n = ' num2str(n_subjects) ')']);
        ylabel('confidence', 'Interpreter', 'none');
        xlabel('% Correct');
        ylim(conf_limit_y);
        xlim([0, 1]);
        % Legend
        legend(legendText, 'Location', 'southwest');
        legend show;
        
        
        % ------ Saving ------
        
        % Only save the figure if we want to
        if(saveFigure)
            
            % Create the file name and path to save
            savingFileName = ['conf_vs_perf_[' stimuliField '](e_total).jpg'];
            savingFilePath = [pwd '/Figures/Overall/' savingFileName];
            
            % Save the data
            saveas(gcf,savingFilePath);
            
        end
        
        
        % ---------- T ----------
        
        figure;
        
        % Go through each condition
        for i = 1:n_conditions
            
            % Color
            color = color_gradient(i,:);
            
            x_mean = perf_T_mean(i,:);
            y_mean = conf_T_mean(i,:);
            
            scatter(x_mean, y_mean, 'MarkerEdgeColor', color, 'Marker', 'o', 'MarkerFaceColor', color);
            
            hold on;
            
        end
        % End of performance plot for loop
        
        % Format graph
        title(['Confidence vs. Performance [' stimuliField '] (T Evidence) (n = ' num2str(n_subjects) ')']);
        ylabel('confidence', 'Interpreter', 'none');
        xlabel('% Correct');
        ylim(conf_limit_y);
        xlim([0, 1]);
        % Legend
        legend(legendText, 'Location', 'southwest');
        legend show;
        
        
        % ------ Saving ------
        
        % Only save the figure if we want to
        if(saveFigure)
            
            % Create the file name and path to save
            savingFileName = ['conf_vs_perf_[' stimuliField '](e_T).jpg'];
            savingFilePath = [pwd '/Figures/Overall/' savingFileName];
            
            % Save the data
            saveas(gcf,savingFilePath);
            
        end
        
        
        % ---------- Furl ----------
        
        figure;
        
        % Go through each condition
        for i = 1:n_conditions
            
            % Color
            color = color_gradient(i,:);
            
            x_mean = perf_furl_mean(i,:);
            y_mean = conf_furl_mean(i,:);
            
            scatter(x_mean, y_mean, 'MarkerEdgeColor', color, 'Marker', 'o', 'MarkerFaceColor', color);
            
            hold on;
            
        end
        % End of performance plot for loop
        
        % Format graph
        title(['Confidence vs. Performance [' stimuliField '] (Furl Evidence ((T-N)/D)) (n = ' num2str(n_subjects) ')']);
        ylabel('confidence', 'Interpreter', 'none');
        xlabel('% Correct');
        ylim(conf_limit_y);
        xlim([0, 1]);
        % Legend
        legend(legendText, 'Location', 'southwest');
        legend show;
        
        
        % ------ Saving ------
        
        % Only save the figure if we want to
        if(saveFigure)
            
            % Create the file name and path to save
            savingFileName = ['conf_vs_perf_[' stimuliField '](e_furl).jpg'];
            savingFilePath = [pwd '/Figures/Overall/' savingFileName];
            
            % Save the data
            saveas(gcf,savingFilePath);
            
        end
        
        
    end
    
    
    
    
end