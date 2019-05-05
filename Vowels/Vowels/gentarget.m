function res = gentarget(peak_data,half,good_len)
    next = 1;
    for i = 1:12
        for j = (half+1):2:good_len %Iterate over the selected half=0|1 of the data.
            if(peak_data(i,1,j))
                targetcol = zeros(12,1);
                targetcol(i,1) = 1;
                target(:,next) = targetcol;
                next = next+1;
            end
        end
    end
    %Structure with cell_{ij} = 1 if data point j is class i, zero otherwise.
    res = target;
end