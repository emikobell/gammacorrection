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



