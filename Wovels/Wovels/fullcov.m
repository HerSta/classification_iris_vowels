function res = fullcov(peak_data,good_len)
    peak_size = size(peak_data);
    len = peak_size(2);
    res = zeros(12,len,len);
    for i = 1:12
        %For this class find the sample covariane of all parameters.
        res(i,:,:) = cov(squeeze(peak_data(i,:,1:good_len)).');
    end
end