function res = genoutputs(peak_data)
    class_covs = cl_cov(peak_data);
    class_means = cl_mean(peak_data);
    next = 1;
    for i = 1:12
        for j = 71:139
            if(peak_data(i,1,j))
                res(:,next) = classify(peak_data(i,1,j),peak_data(i,2,j),peak_data(i,3,j),class_means,class_covs);
                next = next+1;
            end
        end
    end
end