function gammaAnalysis

% Loads 20 participants' data for grey-matching with 3 repeats each and plots them by participant.
% Also calculates the means for each repeat per participant, calculates the grand means per pattern, and calculates the standard error.
% All the above data is outputted as a CSV.
% The input data should be outputted by GeneratePerceptualGamma for optimal performance.
% 2/1/2021 Emiko Bell


listOfIdentifiers = nchoosek('ABCDEF', 3); % Generate a list of identifiers by randomly bunching triplets of the alphabets specified. This line is identical to the one in GeneratePerceptualGammaData.
numParticipants = length(listOfIdentifiers); % Identify the number of participants by choosing the length of identifiers
averageHalftones = zeros(8, numParticipants); % Create a matrix for average half-tones
totalAverage = zeros(8, 1); % Create a vertical matrix for the grand mean of each pattern
sdHalftones = zeros(8, 1); % Create a vertical matrix for the standard error of each pattern from the grand mean

    for k = 1:8 % For each pattern
        
        for i = 1:numParticipants % For each participant
            gammaData = readmatrix(['PerceptualGamma_' listOfIdentifiers(i, :) '.csv']); % Read the participant data CSV
            greytoneData = gammaData(k, [2:4]); % Identify the grey-tone data for the pattern by the pattern iteration number. Remove the first column, since it labels the patterns IDs
            averageHalftones(k, i) = mean(greytoneData); % Calculate the average for the pattern
            participantLabel{i} = ['Participant ' int2str(i)]; % Label for each participant
        end
        
        totalAverage(k) = mean(averageHalftones(k, :)); % Calculate the grand means from all participants for each pattern
        sdHalftones(k) = std(averageHalftones(k, :)); % Calculate the standard deviation (error in this case) for each participant's pattern mean from the grand mean
        labelNames{k} = ['Halftone ' int2str(k)]; % Create labels above each respective halftone
    end

gammaAnalysisTable = cat(2, averageHalftones, totalAverage, sdHalftones); % Concatenate participant means, grand means, and standard errors by columns
    
gammaAnalysisTable = array2table(gammaAnalysisTable, 'VariableNames', cat(2, participantLabel, {'Grand Mean'}, {'Standard Deviation'}), 'RowNames', labelNames) % Convert matrix to table and add labels

writetable(gammaAnalysisTable, 'PerceptualGammaData.csv'); % Output as CSV

x = 1:8; % Define x data
bar(x, totalAverage); % Create a bar plot with pattern numbers on x and grand means on y

hold on % Do not clear plot

er = errorbar(x, totalAverage, [sdHalftones .* -1], sdHalftones); % Define error bars as -1 and +1 standard error from the grand mean
er.Color = [0 0 0]; % Black error bar color
er.LineStyle = 'none'; % No lines from one error bar to another
title('Grey-Level Averages by Halftone Pattern') % Title of plot
xlabel('Halftone Pattern') % x-axis label
ylabel('Average grey-level of brightness match') % y-axis label

hold off

saveas(gcf, 'AverageGammaPerceptionBarPlot.png') % Save current plot as .png

end