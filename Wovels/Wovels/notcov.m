function res = notcov(peak_data)
    res = zeros(12,3,3);
    for i = 1:12
        tmp = cov(squeeze(peak_data(i,:,1:70)).');
        for(j = 1:3)
            res(i,j,j) = tmp(j,j);
        end
    end
end