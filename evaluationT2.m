%% Evaluation script, T2 decay fitting.

% Reset MATLAB environment.
clear all;
close all;

% Add paths.
addpath('tools/');
addpath('algorithms/');
addpath('algorithms/objectiveFunctions/');



%Loop for Multiple Noise Values
folder = dir('/home/hoffman/github/MATLAB/projects/inSilicoPhantoms/relaxation/images/T2images');
y = numel(folder);

for x = 3:y

% Load data.
file = sprintf('/home/hoffman/github/MATLAB/projects/inSilicoPhantoms/relaxation/data_%d.mat',x);
% Load data.
data = load(file);
ydata = double(data.im(:,:,:));
xdata = data.TE;

mask = (zeros(size(ydata)));
mask(51:206,51:206,:) = 1;
ydata = ydata.*mask;

% Create pool for parallel processing.
if matlabpool('size') == 0
    matlabpool('open');
end

% Initial guess for solution.
dataSize = size(ydata);
numberOfPixels = dataSize(1)*dataSize(2);
initialGuess = ones(3, numberOfPixels);
initialGuess = initialGuess*2500;

% Define bounds.
bounds = [ 0, 4096; 0, 2500; 0, 4096 ];

% Pixel-by-pixel curve fit.
tic();
solutionPixel = pixelFit(xdata, ydata, @objectiveFunctionT2, initialGuess, bounds);
processingTimePixel = toc();

% Vector curve fit.
%tic();
%solutionVector = vectorFit(xdata, ydata, @objectiveFunctionT2, initialGuess, bounds);
%processingTimeVector = toc();

% Vector chunks curve fit.
tic();
solutionVectorChunks = vectorChunksFit(xdata, ydata, @objectiveFunctionT2, initialGuess, bounds);
processingTimeVectorChunks = toc();

% Chris' curve fit.
%tic();
%solutionChris = chrisT2Fit(xdata, ydata);
%processingTimeChris = toc();

figure;
imagesc(ydata(:,:,1));
title('magnitude image');
colormap gray;
xlabel('x / px');
ylabel('y / px');
h = colorbar;
set(get(h,'ylabel'),'String', 'signal magnitude / a.u.');
snapnow;

fprintf('Processing times:\n');
fprintf('   pixel-by-pixel, parfor:                    % 7.2f s\n', processingTimePixel);
%fprintf('   vector, simultaneous fit:                  % 7.2f s\n', processingTimeVector);
fprintf('   vector chunks, piecewise simultaneous fit: % 7.2f s\n', processingTimeVectorChunks);
%fprintf('   Chris'' way:                                % 7.2f s\n', processingTimeChris);

figure;
imagesc(squeeze(solutionPixel(2,:,:)));
title('T_2 map (pixel-by-pixel, parfor)');
colormap jet;
xlabel('x / px');
ylabel('y / px');
caxis([0 100]);
h = colorbar;
set(get(h,'ylabel'),'String', 'T2 / ms');
snapnow;

echoTimes  = repmat( reshape( xdata, [1 1 size(xdata,1)]), [size(ydata,1) size(ydata,2) 1]);
amplitudes = repmat( reshape( solutionPixel(1,:,:), [size(ydata,1) size(ydata,2) 1]), [1 1 size(xdata,1)]);
t2times    = repmat( reshape( solutionPixel(2,:,:), [size(ydata,1) size(ydata,2) 1]), [1 1 size(xdata,1)]);

valid = ((~isnan(amplitudes)) & (~isnan(t2times)) & (amplitudes > 0) & (t2times > 0));
error = rmse( ydata(valid), amplitudes(valid) .* exp( -echoTimes(valid) ./ t2times(valid)) );
fprintf('RMSE = %.3f\n', error);

%figure;
%imagesc(squeeze(solutionVector(2,:,:)));
%title('T_2 map (vector, simultaneous fit)');
%colormap jet;
%xlabel('x / px');
%ylabel('y / px');
%caxis([0 100]);
%h = colorbar;
%set(get(h,'ylabel'),'String', 'T2 / ms');
%snapnow;

%amplitudes = repmat( reshape( solutionVector(1,:,:), [size(ydata,1) size(ydata,2) 1]), [1 1 size(xdata,1)]);
%t2times    = repmat( reshape( solutionVector(2,:,:), [size(ydata,1) size(ydata,2) 1]), [1 1 size(xdata,1)]);

%valid = ((~isnan(amplitudes)) & (~isnan(t2times)) & (amplitudes > 0) & (t2times > 0));
%error = rmse( ydata(valid), amplitudes(valid) .* exp( -echoTimes(valid) ./ t2times(valid)) );
%fprintf('RMSE = %.3f\n', error);

figure;
imagesc(squeeze(solutionVectorChunks(2,:,:)));
title('T_2 map (vector chunks, piecewise simultaneous fit)');
colormap jet;
xlabel('x / px');
ylabel('y / px');
caxis([0 100]);
h = colorbar;
set(get(h,'ylabel'),'String', 'T2 / ms');
snapnow;

amplitudes = repmat( reshape( solutionVectorChunks(1,:,:), [size(ydata,1) size(ydata,2) 1]), [1 1 size(xdata,1)]);
t2times    = repmat( reshape( solutionVectorChunks(2,:,:), [size(ydata,1) size(ydata,2) 1]), [1 1 size(xdata,1)]);

valid = ((~isnan(amplitudes)) & (~isnan(t2times)) & (amplitudes > 0) & (t2times > 0));
error = rmse( ydata(valid), amplitudes(valid) .* exp( -echoTimes(valid) ./ t2times(valid)) );
fprintf('RMSE = %.3f\n', error);

%figure;
%imagesc(squeeze(solutionChris(2,:,:)));
%title('T_2 map (Chris'' method)');
%colormap jet;
%xlabel('x / px');
%ylabel('y / px');
%caxis([0 100]);
%h = colorbar;
%set(get(h,'ylabel'),'String', 'T2 / ms');
%snapnow;

%amplitudes = repmat( reshape( solutionChris(1,:,:), [size(ydata,1) size(ydata,2) 1]), [1 1 size(xdata,1)]);
%t2times    = repmat( reshape( solutionChris(2,:,:), [size(ydata,1) size(ydata,2) 1]), [1 1 size(xdata,1)]);

%valid = ((~isnan(amplitudes)) & (~isnan(t2times)) & (amplitudes > 0) & (t2times > 0));
%error = rmse( ydata(valid), amplitudes(valid) .* exp( -echoTimes(valid) ./ t2times(valid)) );
%fprintf('RMSE = %.3f\n', error);

% Plot results.
plotDecay( 51, 51, xdata, ydata, solutionPixel, solutionVectorChunks); % Liver
plotDecay(  51, 151, xdata, ydata, solutionPixel, solutionVectorChunks); % Fat
plotDecay( 151, 51, xdata, ydata, solutionPixel, solutionVectorChunks); % Aorta
plotDecay( 151, 151, xdata, ydata, solutionPixel, solutionVectorChunks); % Bone
end