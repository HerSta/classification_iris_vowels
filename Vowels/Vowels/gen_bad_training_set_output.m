function res = gen_bad_training_set_output(peak_data,half,good_len)
    class_covs = notcov(peak_data,half,good_len);
    class_means = cl_mean(peak_data,half,good_len);
    offset = good_len/2;
    res = zeros(12,12*offset);
    for i = 1:12
        res(:,offset*(i-1)+1:i*offset) = classify(peak_data(i,:,(half+1):2:good_len),class_means,class_covs);
    end
end