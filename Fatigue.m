%exercise 3.1
% Using the “fatigue” data, based on the findings in Exercise 2.2, use the optimal window size and feature to 
%compute short-time analysis on the “fatigue” signal to examine the relative activity of the signal.   Correlate the results of 
%your short-time analysis to the force signal in  a manner of your choosing.   Describe  your algorithm, plot all results and 
%discuss your findings. 

clear
close all
%open file
grasp = ('C:\Users\nazif\Documents\MATLAB\BME632\LAB2\GraspFatigue.csv');
data = readtable(grasp);
data = data(50:end,:); %to discard the noise at the begining of signal
force = data.GripStrengthForce;

%Time

sampfreq = 1000; %setting sampling rate given in lab
samprate = 1/sampfreq;
len = size(data{:,1})-1;
time = 0: samprate : (len/sampfreq);

%normalize signal
nf = (force - min(force))./(peak2peak(force));

%EMG fatigue
figure(1)
subplot(2,1,1)
plot(time, force)
title('Lab 2 - Exercise 3.1: Fatigue Signal');
xlabel('Time(sec)'); ylabel('Force (a.u.)'); grid on;
subplot(2,1,2)
plot(time, nf)
title('Lab 2 - Exercise 3.1: Normalize Fatigue Signal');
xlabel('Time(sec)'); ylabel('Force (a.u.)'); grid on;

%retrieve table values 
size = sampfreq*0.02;
[meanrecnf,varnf,dynnf,avgnf,rmsnf]=Window(nf,size);
[meanrecngf,varngf,dynngf,avgngf,rmsngf]=Window(nf,size);


figure(2)
plot(time,nf,'b--')
hold on
plot(time,avgngf,'m')
legend('Force Signal','Average Power') 
title('Lab 2 - Exercise 3.1: Grip Force Signal and Average power');
xlabel('Time(sec)'); ylabel('Force (a.u.)'); grid on;


