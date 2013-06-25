function [ DI] = makeMATRIXt1( T1,TI,stdev)
%this function will form a DICOM matrix for a T1 image
%   pre allocate matrix of zeros and depending on the number of elements in
%   the TI vector the matrix will be formed differently

%magnitude that will be used for DICOM images
M = 2048;

% find the number of images to make
n = numel(TI);

%prealocating matrix of zeros for ST1 for loop
ST1 = zeros(n,numel(T1));

% calulate signal with no background use 2048 because average DICOM value
%calculates a signal and stores into a matrix
for ii = 1:n
ST = [M*abs((1 - 2.*exp(TI(ii)./T1)))];
ST1(ii,:) = ST;
end

%makes the above signal into a correctly formatted matrix size
[DI] = makeBOX(n,ST1);

%make noise
[DI] = makeNOISE(M,stdev,DI);


end