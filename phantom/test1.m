%choosing the type of image you want to create

% the while loop is used to repeat if errors are mad in the input
while 2 == 2;
choice = menu('Choose the type of desired image','T1','T2','T1 and T2');

% choice 0 is for exiting from the menu box
if choice == 0 ;
    disp('program was exit out of')
    break;

%choice 1 is for T1 inversion recovery 
elseif choice == 1;
    
    %input for T1 is acquired here as a string then converted to numbers
    str = inputdlg('please enter up to 9 T1 values seperated by a space or comma','s');
    T1 = str2num(str{1});
    
    %this is a catch for an error to many inputs entered
    if numel(T1)>9
       warndlg('The typed number of inputs must be 9 or less')
    continue;
    else
        
    %input values for the desired TI is entered here as a string then
    %converted to a number.
        str = inputdlg('please enter associated TI values seperated by a space or comma','s');
        TI = str2num(str{1});
        
        %input the standard deviation to be used in creating noise for
        %image
        str = inputdlg('please enter the standard deviation as a decimal','s');
        stdev = str2num(str{1});
    
        %forming the t1 matrix with function makeMATRIXt1
        [DI] = makeMATRIXt1(T1,TI,stdev);
        DI = uint16(DI);
        dicomwrite(DI,'/home/hoffman/github/MatlabCurveFit/phantom/images/test.dcm','T1',T1);
       break;
    end

    %choice 2 is a T2 image that has been chosen
elseif choice == 2;
    
    %input for T2 is acquired here as a string then converted to numbers
    str = inputdlg('please enter up to 9 T2 values seperated by a space or comma','s');
    T2 = str2num(str{1});
    
    %this is a catch for an error to many inputs entered
    if numel(T2)>9
       warndlg('The typed number of inputs must be 9 or less')
       continue;
    else
        
    %input values for the desired TE is entered here as a string then
    %converted to a number.
        str = inputdlg('please enter associated TE values seperated by a space or comma','s');
        TE = str2num(str{1});
            
         %input the standard deviation to be used in creating noise for
        %image
        str = inputdlg('please enter the standard deviation as a decimal','s');
        stdev = str2num(str{1});
        
    %forming the t2 matrix with function makeMATRIXt2
        [DI] = makeMATRIXt2(T2,TE,stdev);
        break;
   end
   
    % choice 3 makes a matrix for both T1 and T2 inversion recovery it uses
    % the same error catches as above set up only difference is there will
    % be two matrixs formed DI1 and DI2
else choice == 3;
    str = inputdlg('please enter up to 9 T1 values seperated by a space or comma','s');
    T1 = str2num(str{1});
    if numel(T1)>9
        warndlg('The typed number of inputs must be 9 or less')
        continue;
    else
        str = inputdlg('please enter associated TI values seperated by a space or comma','s');
        TI = str2num(str{1});
        
        str = inputdlg('please enter the standard deviation as a decimal','s');
        stdev1 = str2num(str{1});
        
        [DI1] = makeMATRIXt1(T1,TI,stdev1);
        
    end
    str = inputdlg('please enter up to 9 T2 values seperated by a space or comma','s');
    T2 = str2num(str{1});
    if numel(T2)>9
        warndlg('The typed number of inputs must be 9 or less')
        continue;
    else
        str = inputdlg('please enter associated TE values seperated by a space or comma','s');
        TE = str2num(str{1});
     
        str = inputdlg('please enter the standard deviation as a decimal','s');
        stdev2 = str2num(str{1});
        
        [DI2] = makeMATRIXt2(T2,TE,stdev2);
        break;
        
    end
end
end
