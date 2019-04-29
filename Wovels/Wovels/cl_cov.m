function class_covs = cl_cov(peak_data)
    class_covs = zeros(12,3,3);
    for i = 1:12
        class_covs(i,:,:) = cov(squeeze(peak_data(i,:,1:2:139)).');
    end
end