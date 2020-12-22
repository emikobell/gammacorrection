function plotGamma

listOfIdentifiers = nchoosek('ABCDEF', 3);
numParticipants = length(listOfIdentifiers);
t = tiledlayout(4, 5);
title(t, 'Raw Grey-Levels vs Halftone Pattern by Participant')
xlabel(t, 'Mean intensity of halftone pattern')
ylabel(t, 'Grey-level of brightness match')

    for i = 1:numParticipants
        gammaData = readmatrix(['PerceptualGamma_' listOfIdentifiers(i, :) '.csv']);
        x = gammaData(:, 1);
        y = gammaData(:, [2:4]); %Specifying the column data to only include the repeat patterns
        nexttile
        plot(x, y)
        hold on
        xlim([1 8])
        ylim([0 1]) %Lower and higher level set to go across all potential grey-levels
        title(['Participant ' num2str(i)]);
    end

t = gcf; %Choosing current figure window from tiledlayout
t.WindowState = 'maximized'; %Make figure window full screen
end