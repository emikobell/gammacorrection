%Q1: Creating an array from 0 to 1 in 0.05 increments

requestedSignal = [0:0.05:1];

% Using power-law formula to calculate light outputs for each number in the
% array

lightOutput = requestedSignal .^ 2.2;

%%

%Q2 Plot a graph of the light output against the signal.

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create plot
plot(requestedSignal, lightOutput);

% Ylabel
ylabel({'Light Output'});

% 
xlabel({'Requested Signal'});


%The "GraphicsSmoothing" checkbox is checked under the Plotting in Property
%Inspector. The smooth function was also used, and the data remained the
%same.

%%

%Q3

%I created a function, alterGamma to output images under different gamma
%values

alterGamma("Bodleian_WTCollection.png", 0.5)
alterGamma("Bodleian_WTCollection.png", 1.0)
alterGamma("Bodleian_WTCollection.png", 2.0)

%%

%Q4 Reading in GammaData as a table, since it's more efficient as a table
%(CITE)

gammaData = readtable('GammaData.csv');

%Plot gamma curve

%If I plot the table of the data as-is, the curve is not smooth. I installed the
%Curve Fitting Toolbox to use the smooth function on the measuredOutput.
%The requestedSignal variable does not need smoothing since the intervals
%between values are consistent.

smoothOutput = smooth(gammaData.measuredOutput)

% Create figure
figure2 = figure;

% Create axes
axes1 = axes('Parent',figure2);
hold(axes1,'on');

% Create plot
plot(gammaData.requestedSignal,smoothOutput);

% Ylabel
ylabel({'Measured Output'});

% Xlabel
xlabel({'Requested Signal'});

%%
%Q5: Curve fit

function PowerLawFit(xValues, yValues)

targetExponent = 2;

%Exponential function is convex and will only provide one answer as the
%best fit, which means that the dataset inputted will have one answer.
%Since most screens will have a gamma of around 2, I will set the starting
%point to 2 to make the algorithm more efficient. However, a starting point
%is not necessary.


figure; hold on;
plot(xValues, yValues, 'rx');

options = fitoptions('Method', 'NonlinearLeastSquares');
options.StartPoint = targetExponent;

f = fit(xValues, yValues, 'x^m', options); 
plot(f, 'b'); legend('hide');

f % the fit parameters are stored in the fit object, returned by the fit function.

%Adding labels to the figure
ylabel({'Light Output'});
xlabel({'Requested Signal'});

%Set the font size to 12, (explain code in detail)
text(0.1, 0.9, ['Best-fitting exponent = ' num2str(f.m, '%3.2f')], 'fontsize', 12);
text(0.1, 0.8, ['y = x ^{' num2str(f.m, '%3.2f') '}'], 'fontsize', 12);
end

%%
%Q6: Output png of test images

function eightTest

binaryElement = zeros(600, 600);

    for i = 1:8
    unit = GenerateThreeByThreeElement(i);
    binaryElement = repmat(unit, 200, 200);
    imwrite(binaryElement, strcat('Pattern', num2str(i), '.png'))
    end
end
%%
% Q7: Have a look at the code in DummySetupInitialStimulus and DummyUpdateStimulus.
% They both also use a custom-written function called DrawDisc. You should be able to call
% these functions as follows:

% [figWindowHandle, wPattern, hPattern] = DummySetupInitialStimulus(1, 0.2);
% pause
% DummyUpdateStimulus(figWindowHandle, wPattern, hPattern, 0.5)

% Describe what happens and why?
% The first line runs a function to draw a gray circle over a square 1/9
% ratio white to black. 

% What’s the benefit of having a DrawDisc function?
%%
%Q8: Using the Psychtoolbox functionality, write two analogous functions to present the
% experimental stimuli on a dedicated experiment screen (using the Screen function in
% Psychtoolbox).

[windowPointer, wPattern, hPattern] = SetupInitialStimulus(1, 0.2);
KbWait;
UpdateStimulus(windowPointer, wPattern, hPattern, 0.5)
KbWait;
CloseandTidy


%%
% Q9
function character = GetKeyPress

character = input('Please adjust the disc grey-level: ', 's');

accepted = ['h' 'b' 'j' 'n' 'm'];

    while isempty(character) | ~ismember(character, accepted) | length(character) > 1
    character = input('Invalid input. Please enter the correct key: ', 's');
    end
    
end
%%
% Q 10:
function currentGreyLevel = RunTrial(numWhite, GreyLevel)

[windowPointer, wPattern, hPattern] = SetupInitialStimulus(numWhite, GreyLevel);
character = GetKeyPress;
    
    while ismember(character, 'hbjn')
    
    small = .0039; %This represents 1/256 of the grey level between 0 to 1; it cannot go inbetween grey levels
    large = .0097; %This is  25/256 of the grey levels (about .1 when 0 to 1)
    
        if character == 'h'
        GreyLevel = GreyLevel + large;
        
        elseif character == 'b'
        GreyLevel = GreyLevel - large;
    
        elseif character == 'j'
        GreyLevel = GreyLevel + small;
    
        elseif character == 'n'
        GreyLevel = GreyLevel - small;
        end
    
    pause(0.1)
    UpdateStimulus(windowPointer, wPattern, hPattern, GreyLevel); %This function will test for limits also
    character = GetKeyPress;
    end
    
    if character == 'm'
    currentGreyLevel = GreyLevel;
    disp("It's a match!")
    end
end

CloseandTidy

%%
%Q11:
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

%%
%Q12:
PerceptualGamma = array2table(PerceptualGamma);
PerceptualGamma.Properties.VariableNames = {'Pattern','Repeat 1','Repeat 2','Repeat 3'};
writetable(PerceptualGamma, ['PerceptualGamma_' int2str(participantID) '.csv']);

Screen('CloseAll');
Screen('Preference', 'Verbosity', oldLevel);
sca
end

%%
% Q13:

GeneratePerceptualGammaData(2916751)

%Generating results ...
%Target Gamma = 2.78

%%
%Q14:
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

%%
% Q15:
gammaAnalysis

%%
% Q16:
fitMeasuredGamma('PerceptualGammaData.csv')
% It was exactly the same as the other function.


