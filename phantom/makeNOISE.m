function [ DI ] = makeNOISE( M,stdev,DI )
%this function adds noise to the real signal that was created by input
%parameters the noise distribution is gaussian.

%creating noise to add to the DICOM image real signal
noise = M.*stdev.*randn([size(DI,1),size(DI,2),size(DI,3)]);

%adding noise to the image
DI = DI + noise;

end

