function RunGreyMatching(participantID)

% Runs grey-matching trials with three repeats for each grey-scale pattern (total 24 trials) and
% outputs a CSV with the matched grey-levels for every trial. This function
% calls RunTrial and its dependent functions.
% 2/1/2021 Emiko Bell

oldLevel = Screen('Preference', 'Verbosity', 1); % Store the old PTB message visibility option, then hiding the visibility
PerceptualGamma = zeros(8, 4); % Create a matrix for the PerceptualGamma data
PerceptualGamma(:, 1) = 1:8; % Fill the first column of the table with the pattern numbers
rng(participantID); % Initialise random number generator with the participantID as the seed
patternNumber = randperm(8); % Creating a random permutation of integers from 1 to 8

Screen('Preference', 'SkipSyncTests', 2); % Skip sync tests for PTB
Screen('Preference', 'VisualDebugLevel', 0); % Remove the visual debug screen on initialisation of PTB
whichScreen = 0; % Choose main window as the stimulus screen
PsychImaging('OpenWindow', whichScreen); % To configure the resolution for Retina screens, this script is needed to call the initial window before alterations
PsychImaging('PrepareConfiguration'); % Call configurations
PsychImaging('AddTask', 'General', 'UseRetinaResolution'); % Add Retina screen compatibility to configurations; if not placed, PTB will default to a basic resolution of 1440 x 900 and the stimulus will not be displayed correctly on Macs with Retina displays. This line will be ignored if the screen is not a Retina screen.
window = Screen(whichScreen, 'OpenWindow', [0 0 0]); % Open the stimulus window with a black background
HideCursor(window) % Hide the cursor on the stimulus display

    for j = 1:3 % Repeat three times for each pattern
        for l = 1:8 % Run for each pattern
            numWhite = patternNumber(l); % Choose a randomly generated integer as the pattern
            PerceptualGamma(numWhite, j+1) = RunTrial(numWhite); % Call RunTrial with the specified pattern, then store the grey-matching value iteratively
            Screen(window, 'Flip'); % Clear PTB screen without closing from RunTrial
        end
    end

white = WhiteIndex(window); % Define white
DrawFormattedText(window, 'Thank you, this is the end of the experiment. \n The Gamma Data CSV has been saved to your working directory.', 'center', 200, white, [], [], [], [2]); % Draw completion text 200 pixels down from the top of the screen
Screen(window, 'Flip'); % Show drawn text on the screen
KbWait; % Wait for input

PerceptualGamma = array2table(PerceptualGamma); % Convert data from matrix to a table for labels
PerceptualGamma.Properties.VariableNames = {'Pattern','Repeat 1','Repeat 2','Repeat 3'}; % Add header with labels
writetable(PerceptualGamma, ['PerceptualGamma_' int2str(participantID) '.csv']); % Save table as a CSV with the participant ID

Screen('CloseAll'); % Close PTB windows
Screen('Preference', 'Verbosity', oldLevel); % Return PTB messages
sca % Quit PTB
end