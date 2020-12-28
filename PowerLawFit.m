
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
ylabel({'Requested Signal'});
xlabel({'Measured Light Output'});

%Set the font size to 12, (explain code in detail)
text(0.5, 0.9, ['Best-fitting exponent = ' num2str(f.m, '%3.2f')], 'fontsize', 12);
text(0.5, 0.8, ['y = x ^{' num2str(f.m, '%3.2f') '}'], 'fontsize', 12);
end