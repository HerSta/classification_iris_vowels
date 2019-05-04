function res = classify(F,class_means,class_covs)
    F_size = size(F);
    ps = zeros(12,F_size(3));
    for i = 1:12
        tmp = reshape(F, [F_size(2) F_size(3)]);
        %probability that the samples in tmp were drawn from class i
        p = mvnpdf(tmp.',squeeze(class_means(i,:)),squeeze(class_covs(i,:,:)));
        ps(i,:) = p;
    end
    res = ps;
end