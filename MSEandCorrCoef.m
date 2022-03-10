% Exercise 2.2
% For at least 20 different window sizes (i.e. 0.02s to 2s), repeat the above analysis and for the mean, MS, and 
% RMS  features,  generate  a  plot  of  MSE  vs.  Correlation  Coefficient  for  each  window  size.  

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
size1 = sampfreq*0.02; 
%normalize signal
ngf = (gf - min(gf))./(peak2peak(gf));
 
for i = 1:20
    
   
    size1 = sampfreq*(0.02+(i*0.1)); 

    
    w_size = (i/100)*sampling_fq; 
    [MRS_FIN1, VAR_FIN1, DYN_FIN1, AVG_FIN1, RMS_FIN1] = Features(sfig1, wsize); 
    [MRS_FIN2, VAR_FIN2, DYN_FIN2, AVG_FIN2, RMS_FIN2] = Features(sfig2, wsize); 
    [MRS_FIN3, VAR_FIN3, DYN_FIN3, AVG_FIN3, RMS_FIN3] = Features(sfig3, wsize);
    [MRS_FIN4, VAR_FIN4, DYN_FIN4, AVG_FIN4, RMS_FIN4] = Features(sfig4, wsize); 
    [MRS_FIN5, VAR_FIN5, DYN_FIN5, AVG_FIN5, RMS_FIN5] = Features(sfig5, wsize);
    [MRS_FIN6, VAR_FIN6, DYN_FIN6, AVG_FIN6, RMS_FIN6] = Features(sfig6, wsize);

    %Mean
    MRS_FIN1 = mean(MRS_FIN1); AVG_FIN1 = mean(AVG_FIN1); RMS_FIN1 = mean(RMS_FIN1);
    MRS_FIN2 = mean(MRS_FIN2); AVG_FIN2 = mean(AVG_FIN2); RMS_FIN2 = mean(RMS_FIN2);
    MRS_FIN3 = mean(MRS_FIN3); AVG_FIN3 = mean(AVG_FIN3); RMS_FIN3 = mean(RMS_FIN3);
    MRS_FIN4 = mean(MRS_FIN4); AVG_FIN4 = mean(AVG_FIN4); RMS_FIN4 = mean(RMS_FIN4);
    MRS_FIN5 = mean(MRS_FIN5); AVG_FIN5 = mean(AVG_FIN5); RMS_FIN5 = mean(RMS_FIN5);
    MRS_FIN6 = mean(MRS_FIN6); AVG_FIN6 = mean(AVG_FIN6); RMS_FIN6 = mean(RMS_FIN6);
    
    mrs_arr = [MRS_FIN1, MRS_FIN2, MRS_FIN3, MRS_FIN4, MRS_FIN5, MRS_FIN6];
    avg_arr = [AVG_FIN1, AVG_FIN2, AVG_FIN3, AVG_FIN4, AVG_FIN5, AVG_FIN6];
    rms_arr = [RMS_FIN1, RMS_FIN2, RMS_FIN3, RMS_FIN4, RMS_FIN5, RMS_FIN6];
    
    for j = 1:(length(finger)-w_size)
        fin_win = finger(j:(j+w_size));
        mrs(j) = mean(fin_win);
        avg(j) = (rms(fin_win))^2;
        rmsq(j) = rms(fin_win);    
    end
    
    for j = 1:(length(finger)-w_size)
       fin_win = finger(j:(j+w_size));
       f_mrs(j) = mean(fin_win);
       f_avg(j) = (rms(fin_win))^2;
       f_rmsq(j) = rms(fin_win);     
    end
     
     coef_mrs = corrcoef(f_avg, avg); 
     coef_avg = corrcoef(f_mrs, mrs); 
     coef_rmsq = corrcoef(f_rmsq, rmsq); 

     MSE_mrs = immse(f_mrs, mrs);
     MSE_avg = immse(f_avg, avg); 
     MSE_rmsq = immse(f_rmsq, rmsq); 
   
     root_avg(i) = coef_avg(1,2);
     root_mrs(i) = coef_mrs(1,2);
     root_rmsq(i) = coef_rmsq(1,2);
    
     %mean sq error 
     avg_MSE(i) = MSE_avg; 
     mrs_MSE(i) = MSE_mrs; 
     rmsq_MSE(i) = MSE_rmsq; 
end 