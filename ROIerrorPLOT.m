function ROIerrorPLOT(solutionPixel,solutionVector,solutionVectorChunks, solutionChris )
%This function will plot the 4 different algorithms with error bars for the
%four different ROIs.

%setting ROI for a 4 T1 sample matrix
ROIpixel1 = solutionPixel(2,51:128,51:128);
ROIvector1 = solutionVector(2,51:128,51:128);
ROIvectorChunks1 = solutionVectorChunks(2,51:128,51:128);
ROIchris1 = solutionChris(2,51:128,51:128);

ROIpixel2 = solutionPixel(2,51:128,129:206);
ROIvector2 = solutionVector(2,51:128,129:206);
ROIvectorChunks2 = solutionVectorChunks(2,51:128,129:206);
ROIchris2 = solutionChris(2,51:128,129:206);

ROIpixel3 = solutionPixel(2,129:206,51:128);
ROIvector3 = solutionVector(2,129:206,51:128);
ROIvectorChunks3 = solutionVectorChunks(2,129:206,51:128);
ROIchris3 = solutionChris(2,129:206,51:128);

ROIpixel4 = solutionPixel(2,129:206,129:206);
ROIvector4 = solutionVector(2,129:206,129:206);
ROIvectorChunks4 = solutionVectorChunks(2,129:206,129:206);
ROIchris4 = solutionChris(2,129:206,129:206);

% calculate mean value for use in error bar plot
meanVAL1 = [ mean(ROIpixel1(:)) mean(ROIvector1(:)) mean(ROIvectorChunks1(:)) mean(ROIchris1(:))];
meanVAL2 = [ mean(ROIpixel2(:)) mean(ROIvector2(:)) mean(ROIvectorChunks2(:)) mean(ROIchris2(:))];
meanVAL3 = [ mean(ROIpixel3(:)) mean(ROIvector3(:)) mean(ROIvectorChunks3(:)) mean(ROIchris3(:))];
meanVAL4 = [ mean(ROIpixel4(:)) mean(ROIvector4(:)) mean(ROIvectorChunks4(:)) mean(ROIchris4(:))];

% calculate standard deviation of all ROI
stdVAL1 = [ std2(ROIpixel1(:)) std2(ROIvector1(:)) std2(ROIvectorChunks1(:)) std2(ROIchris1(:))];
stdVAL2 = [ std2(ROIpixel2(:)) std2(ROIvector2(:)) std2(ROIvectorChunks2(:)) std2(ROIchris2(:))];
stdVAL3 = [ std2(ROIpixel3(:)) std2(ROIvector3(:)) std2(ROIvectorChunks3(:)) std2(ROIchris3(:))];
stdVAL4 = [ std2(ROIpixel4(:)) std2(ROIvector4(:)) std2(ROIvectorChunks4(:)) std2(ROIchris4(:))];

%plot error bar graphs
figure(1);
errorbar(meanVAL1,stdVAL1,'xr')
title('T_1 recovery ROI 1 error');
xlabel('Algorithms');
ylabel('T1 values');
snapnow;

%show mean and standard deviation values
 fprintf('\n');
 fprintf('Mean estimated T1 of ROI 1 \n');
 fprintf(' pixel-by-pixel, parfor: % 7.3f\n vector, simultaneous fit: % 7.3f\n vector chunks, piecewise simultaneous fit: % 7.3f\n Chris'' fit: % 7.3f\n', meanVAL1);
 fprintf('\n');
 fprintf('Standard Deviation ROI 1 \n');
 fprintf(' pixel-by-pixel, parfor: % 7.3f\n vector, simultaneous fit: % 7.3f\n vector chunks, piecewise simultaneous fit: % 7.3f\n Chris'' fit: % 7.3f\n', stdVAL1);
 fprintf('\n');

figure;
errorbar(meanVAL1,stdVAL1,'xr')
title('T_1 recovery ROI 2 error');
xlabel('Algorithms');
ylabel('T1 values');
snapnow;

%show mean and standard deviation values
 fprintf('\n');
 fprintf('Mean estimated T1 of ROI 2 \n');
 fprintf(' pixel-by-pixel, parfor: % 7.3f\n vector, simultaneous fit: % 7.3f\n vector chunks, piecewise simultaneous fit: % 7.3f\n Chris'' fit: % 7.3f\n', meanVAL2);
 fprintf('\n');
 fprintf('Standard Deviation ROI 2 \n');
 fprintf(' pixel-by-pixel, parfor: % 7.3f\n vector, simultaneous fit: % 7.3f\n vector chunks, piecewise simultaneous fit: % 7.3f\n Chris'' fit: % 7.3f\n', stdVAL2);
 fprintf('\n');
 
figure;
errorbar(meanVAL1,stdVAL1,'xr')
title('T_1 recovery ROI 3 error');
xlabel('Algorithms');
ylabel('T1 values');
snapnow;

%show mean and standard deviation values
 fprintf('\n');
 fprintf('Mean estimated T1 of ROI 3 \n');
 fprintf(' pixel-by-pixel, parfor: % 7.3f\n vector, simultaneous fit: % 7.3f\n vector chunks, piecewise simultaneous fit: % 7.3f\n Chris'' fit: % 7.3f\n', meanVAL3);
 fprintf('\n');
 fprintf('Standard Deviation ROI 3 \n');
 fprintf(' pixel-by-pixel, parfor: % 7.3f\n vector, simultaneous fit: % 7.3f\n vector chunks, piecewise simultaneous fit: % 7.3f\n Chris'' fit: % 7.3f\n', stdVAL3);
 fprintf('\n');

figure;
errorbar(meanVAL1,stdVAL1,'xr')
title('T_1 recovery ROI 4 error');
xlabel('Algorithms');
ylabel('T1 values');
snapnow;

%show mean and standard deviation values
 fprintf('\n');
 fprintf('Mean estimated T1 of ROI 4 \n');
 fprintf(' pixel-by-pixel, parfor: % 7.3f\n vector, simultaneous fit: % 7.3f\n vector chunks, piecewise simultaneous fit: % 7.3f\n Chris'' fit: % 7.3f\n', meanVAL4);
 fprintf('\n');
 fprintf('Standard Deviation ROI 4 \n');
 fprintf(' pixel-by-pixel, parfor: % 7.3f\n vector, simultaneous fit: % 7.3f\n vector chunks, piecewise simultaneous fit: % 7.3f\n Chris'' fit: % 7.3f\n', stdVAL4);
 fprintf('\n');

end

