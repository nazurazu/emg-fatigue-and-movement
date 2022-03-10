function [res] = Residuals(true,estimate)
    res=zeros(6,1);
    for i=1:6
        res(i)=true(i)-estimate(i);
    end
end