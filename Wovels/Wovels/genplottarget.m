function res = genplottarget(peak_data)
    next = 1;
    for i = 1:12
        for j = 2:2:138
            if(peak_data(i,1,j))
                target(next) = i;
                next = next+1;
            end
        end
    end
    res = target;
end