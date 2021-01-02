function plotLightOutput(requestedSignal, lightOutput)

% Receives light output data and requested signal data to plot a Gamma curve.
% Outputs the plot as a .png file.
% 2/1/2021 Emiko Bell

lightOutput = smooth(lightOutput); % Smooth lightOutput data before plotting the curve

% Create figure
figure1 = figure;

% Create axes and axes limits
axes1 = axes('Parent',figure1);
hold(axes1,'on');
xlim([0 1])
ylim([0 1])

% Create plot
plot(requestedSignal, lightOutput);

% Create labels
xlabel({'Requested Signal'});
ylabel({'Light Output'});

% Output .png file of the plot
saveas(gcf, 'GammaDataPlot.png') 
end