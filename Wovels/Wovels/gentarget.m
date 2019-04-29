function res = gentarget(peak_data)
    next = 1;
    for i = 1:12
        for j = 2:2:138
            if(peak_data(i,1,j))
                targetcol = zeros(12,1);
                targetcol(i,1) = 1;
                target(:,next) = targetcol;
                next = next+1;
            end
        end
    end
    res = target;
end