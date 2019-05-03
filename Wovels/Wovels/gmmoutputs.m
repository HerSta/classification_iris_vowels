function res = gmmoutputs(peak_data,half,good_len,order)
    offset = good_len/2;
    res = zeros(12,12*offset);
    options = statset('MaxIter',500);
    for j = 0:11
        for i = 1:12
            sample = squeeze(peak_data(j+1,:,(half+1):2:good_len)).';
            GMM = fitgmdist(squeeze(peak_data(i,:,(~half+1):2:good_len)).',order,'RegularizationValue',10^(-10),'Options',options); 
            res(i,(j*offset+1):((j+1)*offset)) = pdf(GMM,sample).';
        end
    end
end