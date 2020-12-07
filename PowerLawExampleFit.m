function PowerLawExampleFit
% An example of using Matlab's fit function to fit a power-law to some
% simulated data
% HES 26/11/2020

rng('shuffle') % seed the random number generator based on current time

targetExponent = 2; % the exponent of the "ideal" power-law data, before adding noise

xValues = [0:0.1:1]'; 
yValues = xValues .^ targetExponent + (0.01 .* randn(size(xValues))); % simulated noisy data

figure; hold on;
plot(xValues, yValues, 'rx');

options = fitoptions('Method', 'NonlinearLeastSquares');
options.StartPoint = targetExponent; % provide a starting value based on the expected power-law

f = fit(xValues, yValues, 'x^m', options); 
plot(f, 'g'); legend('hide');

f % the fit parameters are stored in the fit object, returned by the fit function

text(0.1, 0.9, ['best-fitting exponent = ' num2str(f.m, '%3.2f')], 'fontsize', 14);
text(0.1, 0.8, ['y = x ^{' num2str(f.m, '%3.2f') '}'], 'fontsize', 14);