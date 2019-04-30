function res = notcov(peak_data,half)
    peak_size = size(peak_data);
    len = peak_size(2);
    res = zeros(12,len,len);
    for i = 1:12
        tmp = cov(squeeze(peak_data(i,:,(half+1):2:124)).');
        for(j = 1:len)
            res(i,j,j) = tmp(j,j);
        end
    end
end