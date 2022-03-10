%Exercise 1.1
%For window sizes of 0.05s, 0.25s and 1s, compute each of the features and
%provide a plot for each of the  short-time analysis features overlaid on
%top of the og signal
clear
%open file
isometric = ('C:\Users\nazif\Documents\MATLAB\BME632\LAB2\IsometricMovement.csv');
data = readtable(isometric);
bicep = data.Bicep; 
wrist = data.Wrist;

%Time
sampfreq = 1000; %setting sampling rate given in lab
samprate = 1/sampfreq;
time = 0: length(data.Time) - 1; %array
time = time.*samprate;

%window sizes
size1 = sampfreq*0.05; 
size2 = sampfreq*0.25;
size3 = sampfreq*1;

%Plotting Original Graphs with Features for Bicep at 0.05s
figure(1)
[absmean1, vari1, dyn1, avgp1, rmsq1]= Window(bicep, size1);
plot(time, bicep,time, absmean1,time, vari1,time, dyn1,time, avgp1, time, rmsq1)
title('Lab 2 - Exercise 1.1: Original EMG signal and Features of Bicep Movement at 0.05s Window Size');
xlabel('Time(sec)'); ylabel('EMG (mV)'); 
legend('Original Isometric Bicep Movement', 'Mean Rectified Signal', 'Variance Signal','Dynamic Range Signal', 'Average Power Signal', 'Root Mean Square Signal'); 
axis([1 27 -3 8]);

%Plotting Original Graphs with Features for Bicep at 0.25s
figure(2)
[absmean2, vari2, dyn2, avgp2, rmsq2]= Window(bicep, size2);
plot(time, bicep,time, absmean2,time, vari2,time, dyn2,time, avgp2, time, rmsq2)
title('Lab 2 - Exercise 1.1: Original EMG signal and Features of Bicep Movement at 0.25s Window Size');
xlabel('Time(sec)'); ylabel('EMG (mV)'); 
legend('Original Isometric Bicep Movement', 'Mean Rectified Signal', 'Variance Signal','Dynamic Range Signal', 'Average Power Signal', 'Root Mean Square Signal'); 
axis([1 27 -3 8]);

%Plotting Original Graphs with Features for Bicep at 1s
figure(3)
[absmean3, vari3, dyn3, avgp3, rmsq3]= Window(bicep, size3);
plot(time, bicep,time, absmean3, time, vari3,time, dyn3,time, avgp3, time, rmsq3)
title('Lab 2 - Exercise 1.1: Original EMG signal and Features of Bicep Movement at 1s Window Size');
xlabel('Time(sec)'); ylabel('EMG (mV)'); 
legend('Original Isometric Bicep Movement', 'Mean Rectified Signal', 'Variance Signal','Dynamic Range Signal', 'Average Power Signal', 'Root Mean Square Signal'); 
axis([1 27 -3 8]);

%Plotting Original Graphs with Features for Wrist at 0.05s
figure(4)
[absmean1, vari1, dyn1, avgp1, rmsq1]= Window(wrist, size1);
plot(time, wrist,time, absmean1,time, vari1,time, dyn1,time, avgp1, time, rmsq1)
title('Lab 2 - Exercise 1.1: Original EMG signal and Features of Wrist Movement at 0.05s Window Size');
xlabel('Time(sec)'); ylabel('EMG (mV)'); 
legend('Original Isometric Bicep Movement', 'Mean Rectified Signal', 'Variance Signal','Dynamic Range Signal', 'Average Power Signal', 'Root Mean Square Signal'); 
axis([1 27 -0.7 1.5]);

%Plotting Original Graphs with Features for Wrist at 0.25s
figure(5)
[absmean2, vari2, dyn2, avgp2, rmsq2]= Window(wrist, size2);
plot(time, wrist,time, absmean2,time, vari2,time, dyn2,time, avgp2, time, rmsq2)
title('Lab 2 - Exercise 1.1: Original EMG signal and Features of Wrist Movement at 0.25s Window Size');
xlabel('Time(sec)'); ylabel('EMG (mV)'); 
legend('Original Isometric Bicep Movement', 'Mean Rectified Signal', 'Variance Signal','Dynamic Range Signal', 'Average Power Signal', 'Root Mean Square Signal'); 
axis([1 27 -0.7 1.5]);

%Plotting Original Graphs with Features for Wrist at 1s
figure(6)
[absmean3, vari3, dyn3, avgp3, rmsq3]= Window(wrist, size3);
plot(time, wrist,time, absmean3, time, vari3,time, dyn3,time, avgp3, time, rmsq3)
title('Lab 2 - Exercise 1.1: Original EMG signal and Features of Wrist Movement at 1s Window Size');
xlabel('Time(sec)'); ylabel('EMG (mV)'); 
legend('Original Isometric Bicep Movement', 'Mean Rectified Signal', 'Variance Signal','Dynamic Range Signal', 'Average Power Signal', 'Root Mean Square Signal'); 
axis([1 27 -0.7 1.5]);
