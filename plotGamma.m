function plotGamma

% Plots data from 20 participants outputted by GeneratePerceptualGammaData
% using tiledlayout. 8/1/2021
listOfIdentifiers = nchoosek('ABCDEF', 3); % Generate same identifiers as GeneratePerceptualGammaData
numParticipants = length(listOfIdentifiers); % Define number of participants
t = tiledlayout(4, 5); % Create tiled layout prior to filling them in
title(t, 'Raw Grey-Levels vs Halftone Pattern by Participant') % Create overall title
xlabel(t, 'Mean intensity of halftone pattern') % Create x label for all participants to save space
ylabel(t, 'Grey-level of brightness match') % Create y label for all participants to save space

    for i = 1:numParticipants
        gammaData = readmatrix(['PerceptualGamma_' listOfIdentifiers(i, :) '.csv']); % Read each participant's gamma data
        x = gammaData(:, 1); % Pattern number
        y = gammaData(:, [2:4]); % Specify the column data to only include the repeat patterns
        nexttile % Use next open tile for plot 
        plot(x, y) % Plot data
        hold on
        xlim([1 8]) % x limits for halftone patterns
        ylim([0 1]) % Lower and higher level set to go across all potential grey-levels
        title(['Participant ' num2str(i)]); % Title each plot with participant number
    end

t = gcf; % Choose current figure window from tiledlayout
t.WindowState = 'maximized'; % Make figure window full screen
end