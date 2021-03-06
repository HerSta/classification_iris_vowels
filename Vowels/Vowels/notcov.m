function res = notcov(peak_data,half,good_len)
    peak_size = size(peak_data);
    len = peak_size(2);
    res = zeros(12,len,len);
    for i = 1:12
        %Calculating cov matrix for all classes
        tmp = cov(squeeze(peak_data(i,:,(half+1):2:good_len)).');
        for(j = 1:len)
            %Only returning diagonal
            res(i,j,j) = tmp(j,j);
        end
    end
end