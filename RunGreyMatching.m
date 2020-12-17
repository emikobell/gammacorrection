function RunGreyMatching(participantID)
oldLevel = Screen('Preference', 'Verbosity', 1);

PerceptualGamma = zeros(8, 4);
rng(participantID);
patternNumber = randperm(8);

    for j = 1:3 
        for l = 1:8
            numWhite = patternNumber(l);
            PerceptualGamma(l, 1) = l;
            PerceptualGamma(numWhite, j+1) = RunTrial(numWhite);
        end
    end
    
disp('Thank you, this is the end of the experiment.')

PerceptualGamma = array2table(PerceptualGamma);
PerceptualGamma.Properties.VariableNames = {'Pattern','Repeat 1','Repeat 2','Repeat 3'};
writetable(PerceptualGamma, ['PerceptualGamma_' int2str(participantID) '.csv']);

Screen('Preference', 'Verbosity', oldLevel);
end