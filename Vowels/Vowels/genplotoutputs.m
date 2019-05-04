function res = genplotoutputs(peak_data,half,good_len)
    class_covs = cl_cov(peak_data,~half,good_len);
    class_means = cl_mean(peak_data,~half,good_len);
    offset = good_len/2;
    res = zeros(1,12*offset);
    for i = 1:12
        [M,res(offset*(i-1)+1:i*offset)] = max(classify(peak_data(i,:,(half+1):2:good_len),class_means,class_covs));
    end
end