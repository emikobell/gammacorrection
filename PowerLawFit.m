function PowerLawFit(xValues, yValues)

targetExponent = 2; % Set the "starting point" Gamma as 2

figure; hold on; % Open figure and allow subsequent plot arguments to layer
plot(xValues, yValues, 'kx'); % Plotting the data points using black x markers

options = fitoptions('Method', 'NonlinearLeastSquares'); % Set fit method as nonlinear least squares
options.StartPoint = targetExponent; % Set the starting point gamma for the model

f = fit(xValues, yValues, 'x^m', options); % Run the fit function using exponential model while calling the nonlinear least squares model as an option
plot(f, 'b'); legend('hide'); % Plot the model curve with a blue line


f % Fit parameters are stored in the fit object, returned by the fit function.

% Add labels to the figure
xlabel({'Measured Light Output'});
ylabel({'Requested Signal'});

text(0.5, 0.9, ['Best-fitting exponent = ' num2str(f.m, '%3.2f')], 'fontsize', 12); % Set font size to 12, start the text in the centre of the figure, and 10% lower from the top. Print the "m" of the fit object with 2 decimal points, with 3 digits total.
text(0.5, 0.8, ['y = x ^{' num2str(f.m, '%3.2f') '}'], 'fontsize', 12); % Set font size to 12, start the text in the centre of the figure, and 20% lower from the top. Print the "m" of the fit object with 2 decimal points, with 3 digits total.
end