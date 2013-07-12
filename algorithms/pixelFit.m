%% Parallel pixelwise fitting.
% Copyright (c) The University of Texas MD Anderson Cancer Center, 2013
% Authors: David Fuentes, Florian Maier
function solution = pixelFit(xdata, ydata, objectiveFunction, solution, bounds)

    %find number of parameters from solution
    numPAR = size(solution,1);

    % Set options for fit.
    options = optimset('display', 'off', 'jacobian', 'on' );

    % Get size of data.
    dataSize = size(ydata);
    numberOfPixels  = dataSize(1)*dataSize(2);
    numberOfSamples = dataSize(3);
        
    % Reshape.
    ydata = reshape(ydata, [numberOfPixels, numberOfSamples]);

    % Bounds.
    for ii = 1: numPAR
    lowerBounds(ii) = bounds(ii,1);
    upperBounds(ii) = bounds(ii,2);
    end

    % Loop over pixels.
    parfor i = 1:numberOfPixels

        % Fitting.
        solution(:,i) = lsqcurvefit(objectiveFunction, solution(:,i), xdata, ydata(i,:), lowerBounds, upperBounds, options);
 
    end

    % Reshape solution to format of ydata.
    solution = reshape(solution, [numPAR, dataSize(1), dataSize(2)]);

end
