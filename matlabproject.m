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