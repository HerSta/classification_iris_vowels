function res = genbadoutput(peak_data,half)
    class_covs = notcov(peak_data,~half);
    class_means = cl_mean(peak_data,~half);
    next = 1;
    for i = 1:12
        for j = (half+1):2:124
            if(peak_data(i,1,j))
                res(:,next) = classify(peak_data(i,:,j),class_means,class_covs);
                next = next+1;
            end
        end
    end
end