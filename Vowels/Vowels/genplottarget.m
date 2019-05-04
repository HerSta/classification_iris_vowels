function res = genplottarget(peak_data,half,good_len)
    next = 1;
    for i = 1:12
        for j = (half+1):2:good_len
            if(peak_data(i,1,j))
                target(next) = i;
                next = next+1;
            end
        end
    end
    res = target;
end