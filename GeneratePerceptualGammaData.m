function GeneratePerceptualGammaData(randomSeed)
% A function to generate simulated data from the perceptual gamma
% correction experiment. Data are generated from a model of expected values
% corrupted by noise.
% randomSeed is used to seed the random number generator, so each time the 
% function is called with a particular seed the same data are generated.
% Data are generated for a simulated display with a specified gamma value
% (determined with random noise), viewed by 20 participants, each
% performing 3 repeats.
% e.g. GeneratePerceptualGammaData(1234)
% HES 26/11/2020

disp('Generating results ...');

% Seed the random number generator with the number given in randomSeed
rng(randomSeed);

% Set up parameters such as number of participants, number of trials, etc.

% Generate unique three-letter stings to use as participant identifiers
% '6 choose 3' gives 20 combinations which is perfect for our purpose
listOfIdentifiers = nchoosek('ABCDEF', 3);

numParticipants = length(listOfIdentifiers);
numRepeats = 3;
numPatterns = 8;

% generate a random target gamma value
% plausible values for displays are >1. If it's <1, add 1.
targetGamma = 3 + randn(1,1); 
if targetGamma < 1
    targetGamma = targetGamma + 1;
end
disp(['Target Gamma = ' num2str(targetGamma, '%3.2f')]);

for iP = 1:numParticipants
    
    % initialise arrays to store the data
    labelArray = cell(1,numRepeats);
    dataArray = zeros(numPatterns, 1 + numRepeats);
    dataArray(:, 1) = (1:numPatterns)';
    
    for iR = 1:numRepeats
        % normalised intensities of the patterns
        lightOutput = dataArray(:, 1) / (numPatterns + 1); 
        measurementVariability = 0.02 .* randn(size(lightOutput));
        % simulated brightness match data based on gamma (note in this arrangement we use an exponent of 1/gamma)
        greyLevelMatch = lightOutput .^ (1./targetGamma) + measurementVariability; 
        greyLevelMatch(greyLevelMatch < 0) = 0;
        greyLevelMatch(greyLevelMatch > 1) = 1;
        
        % store the data, using rounding to fix to precision of 2dp
        dataArray(:, 1 + iR) = round(greyLevelMatch * 100)/100;
        % make a label for each repeat
        labelArray{iR} = ['Repeat' int2str(iR)'];
    end
    
    % convert the data array to a table to use variable names
    dataTable = array2table(dataArray, 'VariableNames', cat(2, {'pattern'}, labelArray));
    % write the table to a csv file, using participant identifiers in the filename
    writetable(dataTable, ['PerceptualGamma_' listOfIdentifiers(iP, :) '.csv']);
end

