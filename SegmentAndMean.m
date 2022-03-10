function [meanseg1,meanseg2,meanseg3,meanseg4,meanseg5,meanseg6] = SegmentAndMean(signal,index)
    %segment incoming signals
    seg1 = signal(1:index(1));
    seg2 = signal(index(2):index(3));
    seg3 = signal(index(4):index(5));
    seg4 = signal(index(6):index(7));
    seg5 = signal(index(8):index(9));
    seg6 = signal(index(10):index(11));
    %find the mean of each 
    meanseg1 = mean(seg1);
    meanseg2 = mean(seg2);
    meanseg3 = mean(seg3); 
    meanseg4 = mean(seg4); 
    meanseg5 = mean(seg5); 
    meanseg6 = mean(seg6);
end

