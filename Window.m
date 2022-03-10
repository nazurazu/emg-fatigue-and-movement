%Window Function Script
function [m,v,d,r,a] = Window(signal, size)
   %to fix error "Vectors must be the same length."
   for x = length(signal) : length(signal) + size 
        signal(x) = 0;
   end
   
   for i = 1 : length(signal)-size
       win = signal(i:i+size-1);
       m(i) = mean(abs(win));
       v(i) = var(abs(win));
       d(i) = peak2peak(win);
       a(i) = mean((abs(win)).^2);
       r(i) = rms(win);
   end
end

