%Q1: Creating an array from 0 to 1 in 0.05 increments

requestedSignal = [0:0.05:1];

% Using power-law formula to calculate light outputs for each number in the
% array

lightOutput = requestedSignal .^ 2.2;

%Q2 Plot a graph of the light output against the signal.

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create plot
plot(requestedSignal, lightOutput);

% Create ylabel
ylabel({'Light Output'});

% Create xlabel
xlabel({'Requested Signal'});

box(axes1,'on');
hold(axes1,'off');

%The "GraphicsSmoothing" checkbox is checked under the Plotting in Property
%Inspector.


