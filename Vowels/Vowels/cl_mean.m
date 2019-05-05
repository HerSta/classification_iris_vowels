function class_means = cl_mean(peak_data,half,good_len)
    peak_size = size(peak_data);
    len = peak_size(2);
    class_means = zeros(12,len);
    for k=1:12
        for f=1:len
            %Mean of the selected half of the data,
            class_means(k,f) = mean(nonzeros(peak_data(k,f,(half+1):2:good_len)));
        end
    end
end