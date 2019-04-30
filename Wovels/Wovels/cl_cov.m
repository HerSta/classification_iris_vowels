function class_covs = cl_cov(peak_data,half,good_len)
    peak_size = size(peak_data);
    len = peak_size(2);
    class_covs = zeros(12,len,len);
    for i = 1:12
        class_covs(i,:,:) = cov(squeeze(peak_data(i,:,(half+1):2:good_len)).');
    end
end