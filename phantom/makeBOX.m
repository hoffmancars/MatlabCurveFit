function [ DI ] = makeBOX( n, ST1 )
%this function makes the signal from either t1 or t2 images into a box with
%a 50 pixel border of background around it. Will then be used to eventually
%form a DICOM image. 

col = size(ST1,2);

%form zeros matrix 256x256xn
DI = zeros(256,256,n);

%constant used in forming DICOM matrix 0 boarder
a = 50;

%I2 will be the interior bow with signal can change for a new desired shape
I2 = zeros(156,156,n);

%Takes values from matrix ST1 and places them in a 3 demintional matrix
for ii = 1:n
if col == 1;
   I2(1:end,1:end,ii) = ST1(ii,1); 
elseif col == 2;
    I2(1:end/2,1:end,ii) = ST1(ii,1);
    I2(end/2+1:end,1:end,ii) = ST1(ii,2);
elseif col == 3;
    I2(1:end/3,1:end,ii) = ST1(ii,1);
    I2(end/3+1:(2*end/3),1:end,ii) = ST1(ii,2);
    I2((2*end/3)+1:end,1:end,ii) = ST1(ii,3);
elseif col == 4;
    I2(1:end/2,1:end/2,ii) = ST1(ii,1);
    I2(1:end/2,1+end/2:end,ii) = ST1(ii,2);
    I2(1+end/2:end,1:end/2,ii) = ST1(ii,3);
    I2(1+end/2:end,1+end/2:end,ii) = ST1(ii,4);
elseif col == 5;
    I2(1:end/2,1:end/3,ii) = ST1(ii,1);
    I2(1:end/2,end/3+1:(2*end/3),ii) = ST1(ii,2);
    I2(1:end/2,(2*end/3)+1:end,ii) = ST1(ii,3);
    I2(1+end/2:end,1:end/2,ii) = ST1(ii,4);
    I2(1+end/2:end,1+end/2:end,ii) = ST1(ii,5);
elseif col == 6;
    I2(1:end/2,1:end/3,ii) = ST1(ii,1);
    I2(1:end/2,end/3+1:(2*end/3),ii) = ST1(ii,2);
    I2(1:end/2,(2*end/3)+1:end,ii) = ST1(ii,3);
    I2(1+end/2:end,1:end/3,ii) = ST1(ii,4);
    I2(1+end/2:end,end/3+1:(2*end/3),ii) = ST1(ii,5);
    I2(1+end/2:end,(2*end/3)+1:end,ii) = ST1(ii,6);
elseif col == 7;
    I2(1:end/3,1:end/2,ii) =ST1(ii,1);
    I2(1:end/3,1+end/2:end,ii) = ST1(ii,2);
    I2(end/3+1:(2*end/3),1:end/2,ii) =ST1(ii,3);
    I2(end/3+1:(2*end/3),1+end/2:end,ii) = ST1(ii,4);
    I2((2*end/3)+1:end,1:end/3,ii) = ST1(ii,5);
    I2((2*end/3)+1:end,end/3+1:(2*end/3),ii) = ST1(ii,6);
    I2((2*end/3)+1:end,(2*end/3)+1:end,ii) = ST1(ii,7);
elseif col == 8;
    I2(1:end/3,1:end/2,ii) =ST1(ii,1);
    I2(1:end/3,1+end/2:end,ii) = ST1(ii,2);
    I2(end/3+1:(2*end/3),1:end/3,ii) = ST1(ii,3);
    I2(end/3+1:(2*end/3),end/3+1:(2*end/3),ii) = ST1(ii,4);
    I2(end/3+1:(2*end/3),(2*end/3)+1:end,ii) = ST1(ii,5);
    I2((2*end/3)+1:end,1:end/3,ii) = ST1(ii,6);
    I2((2*end/3)+1:end,end/3+1:(2*end/3),ii) = ST1(ii,7);
    I2((2*end/3)+1:end,(2*end/3)+1:end,ii) = ST1(ii,8);
elseif col == 9;
    I2(1:end/3,1:end/3,ii) = ST1(ii,1);
    I2(1:end/3,end/3+1:(2*end/3),ii) = ST1(ii,2);
    I2(1:end/3,(2*end/3)+1:end,ii) = ST1(ii,3);
    I2(end/3+1:(2*end/3),1:end/3,ii) = ST1(ii,4);
    I2(end/3+1:(2*end/3),end/3+1:(2*end/3),ii) = ST1(ii,5);
    I2(end/3+1:(2*end/3),(2*end/3)+1:end,ii) = ST1(ii,6);
    I2((2*end/3)+1:end,1:end/3,ii) = ST1(ii,7);
    I2((2*end/3)+1:end,end/3+1:(2*end/3),ii) = ST1(ii,8);
    I2((2*end/3)+1:end,(2*end/3)+1:end,ii) = ST1(ii,9);
end
% change below equation to change shape as desired
DI(1+a:end-a,1+a:end-a,ii) = DI(1+a:end-a,1+a:end-a,ii) + I2(:,:,ii);
end
end



