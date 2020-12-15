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
Q5: Curve fit

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

function [windowPointer, wPattern, hPattern] = SetupInitialStimulus(numWhite, startingGreyLevel);
if ~ismember(numWhite, 1:8)
    error('Input argument numWhite is out of range - allowable values are integers 1-8')
end
if startingGreyLevel < 0.0 || startingGreyLevel > 1.0
    error('Input argument startingGreyLevel is out of range - 0 to 1')
end

Screen('Preference', 'SkipSyncTests', 1);
Screen('Preference', 'VisualDebugLevel', 0);
whichScreen = 0;
window = Screen(whichScreen, 'OpenWindow');

black = BlackIndex(window); % pixel value for white

Screen(window, 'FillRect', black); %Making the background white

img = imread(['Pattern' int2str(numWhite) '.png']);

[hPattern, wPattern] = size(img);

set(0,'DefaultFigureVisible','off'); %turning off figure popups

windowPointer = figure;
imshow(img, 'InitialMagnification', 100, 'border', 'tight')
DrawDisc(hPattern, wPattern, startingGreyLevel);
diskImg = getframe(windowPointer);
diskImg = frame2im(diskImg);


set(0,'DefaultFigureVisible','on'); %turning the default back on

textureIndex = Screen(window, 'MakeTexture', diskImg);
Screen(window, 'DrawTexture', textureIndex);

Screen(window, 'Flip');
KbWait;
end

function UpdateStimulus(windowPointer, wPattern, hPattern, updatedGreyLevel)

% Do some error checking on the input parameters
if updatedGreyLevel < 0.0 || updatedGreyLevel > 1.0
    error('Input argument updatedGreyLevel is out of range - 0 to 1')
end
Screen('Preference', 'SkipSyncTests', 1);
Screen('Preference', 'VisualDebugLevel', 0);
whichScreen = 0;
window = Screen(whichScreen, 'OpenWindow');

black = BlackIndex(window); % pixel value for white

Screen(window, 'FillRect', black); %Making the background white

set(0, 'CurrentFigure', windowPointer); %Setting as active figure without a figure popup in Matlab
DrawDisc(wPattern, hPattern, updatedGreyLevel);
diskImg = getframe(windowPointer);
diskImg = frame2im(diskImg);

textureIndex = Screen(window, 'MakeTexture', diskImg);
Screen(window, 'DrawTexture', textureIndex);

Screen(window, 'Flip');

KbWait;
Screen('CloseAll');
end