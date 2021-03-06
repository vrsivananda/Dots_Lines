% This script goes through the data, subject-by-subject, and analyzes them. 
% This analyzes the data in a data structure form by default, but you can
% change it to analyze the cell array or other data if you have it

clear;
close all;

% Create a path to the text file with all the subjects
path='subjects.txt';
% Make an ID for the subject list file
subjectListFileId=fopen(path);
% Read in the number from the subject list
numberOfSubjects = fscanf(subjectListFileId,'%d');

% -------------------------------------------------------------

% Switches and dynamic parameters
saveFigure = 1; % Save the figure
nTrials = 682; % Number of trials in sa
choseDThreshold = 0.20; % %_chosenD to determine discarding

% -------------------------------------------------------------

% SA for discarded subjects
discarded = makeDiscardedSA();

nValidSubjects = 0;
timeElapsed = [];
bonus = {'workerId', 'nCorrect', 'bonus?'};

% Coherence data
coherenceData.Dots.T   = [];
coherenceData.Dots.NT  = [];
coherenceData.Dots.D   = [];
coherenceData.Lines.T  = [];
coherenceData.Lines.NT = [];
coherenceData.Lines.D  = [];

% Chosen stimuli data
chosenStimuliData.Dots.correct     = [];
chosenStimuliData.Dots.confidence  = [];
chosenStimuliData.Lines.correct    = [];
chosenStimuliData.Lines.confidence = [];


% For loop that loops through all the subjects
for i = 1:numberOfSubjects
    
    % Read the subject ID from the file, stop after each line
    subjectId = fscanf(subjectListFileId,'%s',[1 1]);
    % Print out the subject ID
    fprintf('subject: %s\n',subjectId);
    
    % Import the data
    Alldata = load([pwd '/Data/structure_data_' subjectId '.mat']);
    % Structure Array that contains all the data for this subject
    sa = Alldata.data;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%% Your data extraction here %%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Sort the data to follow the trial index (because the order can get
    % jumbled up in the database
    sa = sortSA(sa);
    
    % Make sure the data is valid
    [discardSubject, discarded] = checkForDiscard(sa, discarded, nTrials, choseDThreshold);
    % Criteria for discard:
    % (1) Insufficient trials (Trials do not equal exact amount, might have done exp twice also)
    % (2) Chose D at or above threshold
    
    % Check if we need to bonus the subject
    bonus = checkForBonus(subjectId, sa, discardSubject, bonus);
    
    % If the data is not valid, then we continue to the next subject
    if(discardSubject)
        continue;
    end
    
    % Increment the counter for valid subjects
    nValidSubjects = nValidSubjects + 1;
    
    % Get the coherence data
    coherenceData = getCoherenceData(sa, coherenceData);
    
    % Get the chosenStimuliData
    chosenStimuliData = getChosenStimuliData(sa, chosenStimuliData);
    
    
    
    
    
end % End of for loop that loops through each subject


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Your analysis here %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
% Add path to extra functions, generate colors for each subject
addpath([pwd '/distinguishable_colors']);
colors = distinguishable_colors(nValidSubjects);

% Get the e_norm and e_unnorm data
evidenceData = analyzeEvidence(chosenStimuliData, coherenceData);

% Plot confidence vs percentCorrect
plot_confidence_vs_percentCorrect(evidenceData, saveFigure);









