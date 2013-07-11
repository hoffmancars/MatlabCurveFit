%% Objective function for lsqcurvefit modeling T2 decay.
% Copyright (c) The University of Texas MD Anderson Cancer Center, 2013
% Authors: David Fuentes, Florian Maier
function [ modelVector, modelJacobian ] = objectiveFunctionT2( solutionParameters, echoTimes )

    %% Initialize.
    % Get number of echos, parameters, and pixels.
    numberOfEchos       = size(echoTimes,1);
    numberOfParameters  = size(solutionParameters,1);
    numberOfPixels      = size(solutionParameters,2);

    % Get each model parameter set.
    amplitudes = solutionParameters(1,:);
    t2Times    = solutionParameters(2,:);
    noise      = solutionParameters(3,:);

    %% Evaluate objective function.
    % Initalize vector.
    modelVector = zeros(numberOfPixels, numberOfEchos);

    % Build array of model predicted values.
    for pixelIndex = 1:numberOfPixels
        
        for echoIndex = 1:numberOfEchos
            
            modelVector(pixelIndex,echoIndex) = amplitudes(pixelIndex) * exp(-echoTimes(echoIndex) / t2Times(pixelIndex)) + noise(pixelIndex);
        
        end
        
    end

    %% Calculate Jacobian matrix.
    if nargout > 1
        
        % Initialize vectors for Jacobian of the function.
        jacobianRowIndices = zeros(1,numberOfPixels*numberOfEchos*numberOfParameters);
        jacobianColIndices = zeros(1,numberOfPixels*numberOfEchos*numberOfParameters);
        jacobianEntries    = zeros(1,numberOfPixels*numberOfEchos*numberOfParameters);
        i = 1;

        for pixelIndex = 1:numberOfPixels
            
            for echoIndex = 1:numberOfEchos
                
                % Parameter 1: Amplitude
                parameterIndex = 1;
                jacobianRowIndices(i)   = (echoIndex-1)*numberOfPixels + pixelIndex;
                jacobianColIndices(i)   = (pixelIndex-1)*numberOfParameters + parameterIndex;
                jacobianEntries(i)      = exp(-echoTimes(echoIndex) / t2Times(pixelIndex));

                % Parameter 2: T2
                parameterIndex = 2;
                jacobianRowIndices(i+1) = (echoIndex-1)*numberOfPixels + pixelIndex;
                jacobianColIndices(i+1) = (pixelIndex-1)*numberOfParameters + parameterIndex;
                jacobianEntries(i+1)    = amplitudes(pixelIndex) * exp(-echoTimes(echoIndex) / t2Times(pixelIndex)) * (echoTimes(echoIndex) / t2Times(pixelIndex)^2);

                % Parameter 3: Noise
                parameterIndex = 3;
                jacobianRowIndices(i+2) = (echoIndex-1)*numberOfPixels + pixelIndex;
                jacobianColIndices(i+2) = (pixelIndex-1)*numberOfParameters + parameterIndex;
                jacobianEntries(i+2)    = 1;
                
                % Update Jacobian indices index.
                i = i + 3;

            end
            
        end
        
        % Create sparse matrix.
        modelJacobian = sparse(jacobianRowIndices, jacobianColIndices, jacobianEntries);
        
    end

end
