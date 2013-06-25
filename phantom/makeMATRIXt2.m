function [ DI] = makeMATRIXt2( T2,TE,stdev)
%this function will form a DICOM matrix for a T2 image
%   pre allocate matrix of zeros and depending on the number of elements in
%   the TE vector the matrix will be formed differently

%magnitude that will be used for DICOM images
M = 2048;

% find the number of images to make
n = numel(TE);

%prealocating matrix of zeros for ST2 for loop
ST2 = zeros(n,numel(T2));

%calculates a signal and stores into a matrix
% calulate signal with no background use 2048 because average DICOM value
for ii = 1:n
ST = [M*exp(TE(ii)./T2)];
ST2(ii,:) = ST;
end

[DI] = makeBOX(n,ST2);

%make noise
[DI] = makeNOISE(M,stdev,DI);


end