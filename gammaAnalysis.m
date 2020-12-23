function gammaAnalysis
listOfIdentifiers = nchoosek('ABCDEF', 3);
numParticipants = length(listOfIdentifiers);
averageHalftones = zeros(8, numParticipants);
totalAverage = zeros(8, 1);
sdHalftones = zeros(8, 1);

    for k = 1:8
        
        for i = 1:numParticipants
            gammaData = readmatrix(['PerceptualGamma_' listOfIdentifiers(i, :) '.csv']);
            greytoneData = gammaData(k, [2:4]);
            averageHalftones(k, i) = mean(greytoneData);
            participantLabel{i} = ['Participant ' int2str(i)];
        end
        
        totalAverage(k) = mean(averageHalftones(k, :));
        sdHalftones(k) = std(averageHalftones(k, :));
        labelNames{k} = ['Halftone ' int2str(k)];
    end

gammaAnalysisTable = cat(2, averageHalftones, totalAverage, sdHalftones);
    
gammaAnalysisTable = array2table(gammaAnalysisTable, 'VariableNames', cat(2, participantLabel, {'Grand Mean'}, {'Standard Deviation'}), 'RowNames', labelNames)

writetable(gammaAnalysisTable, 'PerceptualGammaData.csv');

x = 1:8;
bar(x, totalAverage);

hold on

er = errorbar(x, totalAverage, [sdHalftones .* -1], sdHalftones);    
er.Color = [0 0 0];  
er.LineStyle = 'none';
title('Grey-Level Averages by Halftone Pattern')
xlabel('Halftone Pattern')
ylabel('Average grey-level of brightness match')

hold off

saveas(gcf, 'AverageGammaPerceptionBarPlot.png')

end