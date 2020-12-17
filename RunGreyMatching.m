function RunGreyMatching(participantID)

oldLevel = Screen('Preference', 'Verbosity', 1);
PerceptualGamma = zeros(8, 4);
rng(participantID);
patternNumber = randperm(8);

Screen('Preference', 'SkipSyncTests', 2);
Screen('Preference', 'VisualDebugLevel', 0);
whichScreen = 0;
window = Screen(whichScreen, 'OpenWindow', [0 0 0]);
HideCursor(window)

    for j = 1:3 
        for l = 1:8
            numWhite = patternNumber(l);
            PerceptualGamma(l, 1) = l;
            PerceptualGamma(numWhite, j+1) = RunTrial(numWhite);
            Screen(window, 'Flip');
        end
    end

white = WhiteIndex(window);
DrawFormattedText(window, 'Thank you, this is the end of the experiment. \n The Gamma Data CSV has been saved to your working directory.', 'center', 100, white, [], [], [], [2]);
Screen(window, 'Flip');
KbWait;

PerceptualGamma = array2table(PerceptualGamma);
PerceptualGamma.Properties.VariableNames = {'Pattern','Repeat 1','Repeat 2','Repeat 3'};
writetable(PerceptualGamma, ['PerceptualGamma_' int2str(participantID) '.csv']);

Screen('CloseAll');
Screen('Preference', 'Verbosity', oldLevel);
sca
end