function res = gmmoutputs(peak_data,half,good_len,order)
    offset = good_len/2;
    %Test set probabilities 1-12 Training set probabilities 13-24
    res = zeros(24,12*offset);
    options = statset('MaxIter',500);
    for i = 1:12
        %GMM for class i
        GMM = fitgmdist(squeeze(peak_data(i,:,(~half+1):2:good_len)).',order,'RegularizationValue',10^(-10),'Options',options,'CovarianceType','diagonal'); 
        for j = 0:11
            %Test set sample
            sample = squeeze(peak_data(j+1,:,(half+1):2:good_len)).';
            %Training set sample
            sample2 = squeeze(peak_data(j+1,:,(~half+1):2:good_len)).';
            %Test set classification
            res(i,(j*offset+1):((j+1)*offset)) = pdf(GMM,sample).';
            %Training set classification
            res(i+12,(j*offset+1):((j+1)*offset)) = pdf(GMM,sample2).';
        end
    end
end