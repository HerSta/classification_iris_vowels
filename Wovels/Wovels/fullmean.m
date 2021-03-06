function res = fullmean(peak_data,good_len)
    peak_size = size(peak_data);
    len = peak_size(2);
    res = zeros(12,len);
    for k = 1:12
        for f=1:len
            %For all entries of this parameter for this class calculate the sample mean
            res(k,f) = mean(nonzeros(peak_data(k,f,1:good_len)));
        end
    end
end