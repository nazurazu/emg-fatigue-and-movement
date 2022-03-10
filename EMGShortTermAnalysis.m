%Exercise 2.1
clear
close all
%open file
grasp = ('C:\Users\nazif\Documents\MATLAB\BME632\LAB2\GraspForce.csv');
data = readtable(grasp);
data = data(960:end,:); %to discard the noise at the begining of signal
ff = data.Finger_Flexor;  
gf = data.Force;

%Time

sampfreq = 1000; %setting sampling rate given in lab
samprate = 1/sampfreq;
%{
time = 0: length(data.Time) - 1; %array
time = time*samprate;
%}
len = size(data{:,1})-1;
time = 0: samprate : (len/sampfreq);

%2.1 (a)
%Create a figure shows EMG + normalized force signal subplots, 
%indicate the regions/segments on each (using unit step)
%signal where the force is being applied and are used for your calculations. 

%EMG original for finger flexor
figure(1)
subplot(2,1,1)
plot(time, ff)
title('Lab 2 - Exercise 2.1a: Original EMG signal for Finger Flexor');
xlabel('Time(sec)'); ylabel('EMG (mV)'); grid on;
%axis([1 27 -3 10]);

%normalize signal
nff = (ff - min(ff))./(peak2peak(ff));

%Finger flexor mornalized
subplot(2,1,2)
plot(time, nff)
title('Lab 2 - Exercise 2.1a: Normalized signal for Finger Flexor');
xlabel('Time(sec)'); ylabel('EMG (a.u.)'); grid on;


%EMG original for force
figure(2)
subplot(2,1,1)
plot(time, gf)
title('Lab 2 - Exercise 2.1a: Original EMG signal for Grasp Force');
xlabel('Time(sec)'); ylabel('Force (N)'); grid on;

%normalize signal
ngf = (gf - min(gf))./(peak2peak(gf));

%Finger flexor mornalized
subplot(2,1,2)
plot(time, ngf)
title('Lab 2 - Exercise 2.1a: Normalized signal for Grasp Force');
xlabel('Time(sec)'); ylabel('Force (a.u.)'); grid on;


%show areas where the force is applied
appliedForce = zeros(length(ngf), 1);
sqrPulse = zeros(length(ngf), 1);
segmentedff= zeros(length(ngf), 1);

for i = 1:length(ngf)
   if ngf(i)<=0.05
        segmentedff(i)=0;
        appliedForce(i)=0;
        sqrPulse(i)=0;
   else 
        segmentedff(i)=ff(i);
        appliedForce(i)=ngf(i);
        sqrPulse(i)=1;
   end
end

%Plot segmented graphs
figure(3)
subplot(311)
plot(time,segmentedff)
title('Lab 2 - Exercise 2.1a: Finger Flexor During Segments when Force is Applied');
xlabel('Time(sec)'); ylabel('EMG (mV)'); grid on;

subplot(312)
plot(time,appliedForce)
title('Lab 2 - Exercise 2.1a: Force Applied When EMG > 0.05');
xlabel('Time(sec)'); ylabel('Force (a.u.)'); grid on;

subplot(313)
plot(time,sqrPulse)
title('Lab 2 - Exercise 2.1a: Square Pulse Indicating Segments When Force Applied > 0.05');
xlabel('Time(sec)'); ylabel('Amplitude (a.u.)'); grid on;

%Exercise 2.1 b
%create table with features for each segment 
%retrieve table values 
size = sampfreq*0.25;
[meanrecaf,varaf,dynaf,avgaf,rmsaf]=Window(appliedForce,size);

%Segmenting and finding mean of each seg using a function
threshold = appliedForce > 0.1;
seg = find(diff(threshold(:,1))); 
[afseg1,afseg2,afseg3,afseg4,afseg5,afseg6] = SegmentAndMean(gf,seg);
[mrseg1,mrseg2,mrseg3,mrseg4,mrseg5,mrseg6] = SegmentAndMean(meanrecaf,seg);
[varseg1,varseg2,varseg3,varseg4,varseg5,varseg6] = SegmentAndMean(varaf,seg);
[dynseg1,dynseg2,dynseg3,dynseg4,dynseg5,dynseg6] = SegmentAndMean(dynaf,seg);
[avgseg1,avgseg2,avgseg3,avgseg4,avgseg5,avgseg6] = SegmentAndMean(avgaf,seg);
[rmsseg1,rmsseg2,rmsseg3,rmsseg4,rmsseg5,rmsseg6] = SegmentAndMean(rmsaf,seg);

%plot the force and its features 
figure(4)
plot(time,appliedForce,time,meanrecaf,time,varaf,time,dynaf,time,avgaf,time,rmsaf)
title('Lab 2 - Exercise 2.1b: Force Applied and Features of Force at 0.25s Window Size');
xlabel('Time(sec)'); ylabel('Force (a.u.)'); 
legend('Force Applied', 'Mean Rectified Signal', 'Variance Signal','Dynamic Range Signal', 'Average Power Signal', 'Root Mean Square Signal'); 
axis([0 17 0 1.2]);

%display tables
SEGMENT = ["Force", "Mean", "Variance", "DR", "MS", "RMS"]';
F1 = [ afseg1,mrseg1,varseg1,dynseg1,avgseg1,rmsseg1]';
F2 = [ afseg2,mrseg2,varseg2,dynseg2,avgseg2,rmsseg2]';
F3 = [ afseg3,mrseg3,varseg3,dynseg3,avgseg3,rmsseg3]';
F4 = [ afseg4,mrseg4,varseg4,dynseg4,avgseg4,rmsseg4]';
F5 = [ afseg5,mrseg5,varseg5,dynseg5,avgseg5,rmsseg5]';
F6 = [ afseg6,mrseg6,varseg6,dynseg6,avgseg6,rmsseg6]';
Table = table(SEGMENT, F1, F2, F3, F4, F5, F6)

%Exercise 2.1c
%linear regression between force and metric values

%X axis
force = [afseg1,afseg2,afseg3,afseg4,afseg5,afseg6];

%Y axis 
meanrec =[mrseg1,mrseg2,mrseg3,mrseg4,mrseg5,mrseg6];
variance = [varseg1,varseg2,varseg3,varseg4,varseg5,varseg6];
dynrange = [dynseg1,dynseg2,dynseg3,dynseg4,dynseg5,dynseg6];
avgpower = [avgseg1,avgseg2,avgseg3,avgseg4,avgseg5,avgseg6];
rootms = [rmsseg1,rmsseg2,rmsseg3,rmsseg4,rmsseg5,rmsseg6];


%Plot force vs mean rectified
figure(5)
p=polyfit(force,meanrec,1);
p1=polyval(p,force);
plot(force, p1)
hold on
scatter(force,meanrec)
title('Lab 2 - Exercise 2.1c: Average Force vs. Average Mean Rectified of Force for Each Segment');
xlabel('Force(N)'); ylabel('Mean Rectified(a.u.)'); 
grid on;
for i=1:6
    hold on
    plot([force(i) force(i)],[meanrec(i) p1(i)],'b');
end
legend('Polyfit Line y = 0.0025x-0.0151', 'Mean Rectified per Segment'); 


%Plot force vs Variance
figure(6)
p2=polyfit(force,variance,1);
p3=polyval(p2,force);
plot(force, p3)
hold on
scatter(force,variance)
title('Lab 2 - Exercise 2.1c: Average Force vs. Average Variance of Force for Each Segment');
xlabel('Force(N)'); ylabel('Variance(a.u.)'); 
grid on;
for i=1:6
    hold on
    plot([force(i) force(i)],[variance(i) p3(i)],'b');
end
legend('Polyfit Line y = (5.8e-5)x-0.0034', 'Variance per Segment'); 


%Plot force vs Dynamic Range
figure(7)
p4=polyfit(force,dynrange,1);
p5=polyval(p4,force);
plot(force, p5)
hold on
scatter(force,dynrange)
title('Lab 2 - Exercise 2.1c: Average Force vs. Average Dynamic Range of Force for Each Segment');
xlabel('Force(N)'); ylabel('Dynamic Range(a.u.)'); 
grid on;
for i=1:6
    hold on
    plot([force(i) force(i)],[dynrange(i) p5(i)],'b');
end
legend('Polyfit Line y = ((7.27e-4)x - 0.016', 'Dynamic Range per Segment'); 

%Plot force vs Average Power
figure(8)
p6=polyfit(force,avgpower,1);
p7=polyval(p6,force);
plot(force, p7)
hold on
scatter(force,avgpower)
title('Lab 2 - Exercise 2.1c: Average Force vs. Mean Average Power of Force for Each Segment');
xlabel('Force(N)'); ylabel('Average Power(a.u.)'); 
grid on;
for i=1:6
    hold on
    plot([force(i) force(i)],[avgpower(i) p7(i)],'b');
end
legend('Polyfit Line y = 0.0025x-0.0121', 'Average Power per Segment'); 

%Plot force vs Root Mean Squared
figure(9)
p8=polyfit(force,rootms,1);
p9=polyval(p8,force);
plot(force, p9)
hold on
scatter(force,rootms)
title('Lab 2 - Exercise 2.1c: Average Force vs. Average Root Mean Squared of Force for Each Segment');
xlabel('Force(N)'); ylabel('Root Mean Squared(a.u.)'); 
grid on;

for i=1:6
    hold on
    plot([force(i) force(i)],[rootms(i) p9(i)],'b');
end
legend('Polyfit Line y = 0.0026x-0.0197', 'Root Mean Squared per Segment'); 

%Exercise 2.1d
%compute and plot residuals
%residuals were plotted with 2.1c
%for values

SEGMENT = [1, 2, 3, 4, 5, 6]';
[MeanRecResidual] = Residuals(meanrec,p1);
[VarianceResidual] = Residuals(variance,p3);
[DynamicRangeResidual] = Residuals(dynrange,p5);
[AveragePowerResidual] = Residuals(avgpower,p7);
[RootMeanSquareResidual] = Residuals(rootms,p9);
Table = table(SEGMENT, MeanRecResidual, VarianceResidual, DynamicRangeResidual, AveragePowerResidual, RootMeanSquareResidual)

%Plot Residuals
figure(10)
scatter(force,MeanRecResidual,'r')
title('Lab 2 - Exercise 2.1d: Average Force vs. Residual Mean Rectified Force for Each Segment');
xlabel('Force(N)'); ylabel('Residual(a.u.)'); 
grid on;

figure(11)
scatter(force,VarianceResidual,'r')
title('Lab 2 - Exercise 2.1d: Average Force vs. Residual Variance Force for Each Segment');
xlabel('Force(N)'); ylabel('Residual(a.u.)'); 
grid on;

figure(12)
scatter(force,DynamicRangeResidual,'r')
title('Lab 2 - Exercise 2.1d: Average Force vs. Residual Dynamic Range of Force for Each Segment');
xlabel('Force(N)'); ylabel('Residual(a.u.)'); 
grid on;

figure(13)
scatter(force,AveragePowerResidual,'r')
title('Lab 2 - Exercise 2.1d: Average Force vs. Residual Average Power of Force for Each Segment');
xlabel('Force(N)'); ylabel('Residual(a.u.)'); 
grid on;

figure(14)
scatter(force,RootMeanSquareResidual,'r')
title('Lab 2 - Exercise 2.1d: Average Force vs. Residual Root Mean Squared Force for Each Segment');
xlabel('Force(N)'); ylabel('Residual(a.u.)'); 
grid on;

%excercise 2.1e
%MSE and correlation coeficiant, comput and tabulate
CoefmeanRec = corrcoef(p1,meanrec);
Coefvariance = corrcoef(p3,variance);
CoefDynamicRange = corrcoef(p5,dynrange);
CoefAveragePower = corrcoef(p7,avgpower);
CoefRootMeanSquare = corrcoef(p9, rootms);

CoefmeanRec=CoefmeanRec(1,2);
Coefvariance=Coefvariance(1,2);
CoefDynamicRange=CoefDynamicRange(1,2);
CoefAveragePower=CoefAveragePower(1,2);
CoefRootMeanSquare=CoefRootMeanSquare(1,2);

CorrelationCoefficient =[CoefmeanRec; Coefvariance; CoefDynamicRange; CoefAveragePower ;CoefRootMeanSquare];

MSEmeanRec = immse(p1,meanrec);
MSEvariance = immse(p3,variance);
MSEDynamicRange = immse(p5,dynrange);
MSEAveragePower = immse(p7,avgpower);
MSERootMeanSquare = immse(p9,rootms);
MSE = [MSEmeanRec;MSEvariance;MSEDynamicRange;MSEAveragePower;MSERootMeanSquare]; 
%normalize signal
%MSE = (MSE - min(MSE))./(peak2peak(MSE));

Metric = ["Mean Rectified";"Variance";"Dynamic Range";"Average Power";"Root Mean Squared"];

Table = table(Metric, CorrelationCoefficient, MSE)

% Exercise 2.2
% For at least 20 different window sizes (i.e. 0.02s to 2s), repeat the above analysis and for the mean, MS, and 
% RMS  features,  generate  a  plot  of  MSE  vs.  Correlation  Coefficient  for  each  window  size.  

%window sizes
size1 = sampfreq*0.02; 
win = 0.02;
figure(15)

for i = 1:20

    [meanrecaf,varaf,dynaf,avgaf,rmsaf]=Window(appliedForce,size1);

    %Segmenting and finding mean of each seg using a function
    threshold = appliedForce > 0.05;
    seg = find(diff(threshold(:,1))); 
    [afseg1,afseg2,afseg3,afseg4,afseg5,afseg6] = SegmentAndMean(gf,seg);
    [mrseg1,mrseg2,mrseg3,mrseg4,mrseg5,mrseg6] = SegmentAndMean(meanrecaf,seg);
    [avgseg1,avgseg2,avgseg3,avgseg4,avgseg5,avgseg6] = SegmentAndMean(avgaf,seg);
    [rmsseg1,rmsseg2,rmsseg3,rmsseg4,rmsseg5,rmsseg6] = SegmentAndMean(rmsaf,seg);

    %X axis
    force = [afseg1,afseg2,afseg3,afseg4,afseg5,afseg6];

    %Y axis 
    meanrec =[mrseg1,mrseg2,mrseg3,mrseg4,mrseg5,mrseg6];
    avgpower = [avgseg1,avgseg2,avgseg3,avgseg4,avgseg5,avgseg6];
    rootms = [rmsseg1,rmsseg2,rmsseg3,rmsseg4,rmsseg5,rmsseg6];

    %Plot force vs mean rectified
    p=polyfit(force,meanrec,1);
    p1=polyval(p,force);
    p6=polyfit(force,avgpower,1);
    p7=polyval(p6,force);
    p8=polyfit(force,rootms,1);
    p9=polyval(p8,force);
    
    %MSE and correlation coeficiant, comput and tabulate
    CoefmeanRec = corrcoef(p1,meanrec);
    CoefAveragePower = corrcoef(p7,avgpower);
    CoefRootMeanSquare = corrcoef(p9, rootms);

    CoefmeanRec=CoefmeanRec(1,2);
    CoefAveragePower=CoefAveragePower(1,2);
    CoefRootMeanSquare=CoefRootMeanSquare(1,2);
    
 

    MSEmeanRec = immse(p1,meanrec);
    MSEAveragePower = immse(p7,avgpower);
    MSERootMeanSquare = immse(p9,rootms);
    

    
    if win < 0.2
        scatter(CoefmeanRec, MSEmeanRec,'r*')
        hold on
        scatter(CoefAveragePower, MSEAveragePower,'r*')
        hold on
        scatter(CoefRootMeanSquare, MSERootMeanSquare,'r*')
        hold on
        
    elseif win > 1.5
        scatter(CoefmeanRec, MSEmeanRec,'b')
        hold on
        scatter(CoefAveragePower, MSEAveragePower,'g')
        hold on
        scatter(CoefRootMeanSquare, MSERootMeanSquare,'m')
        hold on
    else
        scatter(CoefmeanRec, MSEmeanRec,'k')
        hold on
        scatter(CoefAveragePower, MSEAveragePower,'k')
        hold on
        scatter(CoefRootMeanSquare, MSERootMeanSquare,'k')
        hold on
    end
        
    hold on
    
    win = 0.01+(i*0.1);
    size1 = sampfreq*win; 
    
end
    title('Lab 2 - Exercise 2.2: MSE vs. Correlation Coefficient of Force for Window Size');
    xlabel('Correlation Coefficient(a.u.)'); ylabel('MSE(a.u)'); 
    




