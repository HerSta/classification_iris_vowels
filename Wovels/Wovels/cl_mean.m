function class_means = cl_mean(peak_data)
    class_means = zeros(12,3);
    for k=1:12
        for f=1:3
            class_means(k,f) = mean(nonzeros(peak_data(k,f,1:2:139)));
        end
    end
end