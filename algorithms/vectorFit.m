%% Full vector fitting.
% Copyright (c) The University of Texas MD Anderson Cancer Center, 2013
% Authors: David Fuentes, Florian Maier
function solution = vectorFit(xdata, ydata, objectiveFunction, solution, bounds)

    % Find number of parameters from solution
    numPAR = size(solution,1);

    % Set options for fit.
    options = optimset('display', 'off', 'jacobian', 'on', 'TolFun', 1e-5);
    
    % Get size of data.
    dataSize = size(ydata);
    numberOfPixels  = dataSize(1)*dataSize(2);
    numberOfSamples = dataSize(3);
    
    % Reshape.
    ydata = reshape(ydata, [numberOfPixels, numberOfSamples]);

    % Bounds.
    lowerBounds = ones(numPAR, numberOfPixels);
    upperBounds = ones(numPAR, numberOfPixels);
    
   for ii = 1:numPAR
    lowerBounds(ii,:) = bounds(ii,1) * lowerBounds(ii,:);
    upperBounds(ii,:) = bounds(ii,2) * upperBounds(ii,:);
   end
    
    % Fitting.
    solution = lsqcurvefit(objectiveFunction, solution, xdata, ydata, lowerBounds, upperBounds, options);

    % Reshape solution to format of ydata.
    solution = reshape(solution, [numPAR, dataSize(1), dataSize(2)]);
    
end
