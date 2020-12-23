function fitMeasuredGamma(fileName)

measuredData = readmatrix(fileName);
measuredData = measuredData(:, 21); %Reading only the Grand Mean column of the file
objectiveGreyLevels = zeros(8, 1);

    for i = 1:8
        objectiveGreyLevels(i) = i/9;
    end

PowerLawFit(measuredData, objectiveGreyLevels)
end