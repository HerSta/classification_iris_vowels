function res = classify(F,class_means,class_covs)
    ml = 0;
    mli = 0;
    p = 0;
    ps = zeros(12,1);
    for i = 1:12
        p = mvnpdf(F,squeeze(class_means(i,:)),squeeze(class_covs(i,:,:)));
        ps(i,1) = p;
        if(p>ml)
            ml = p;
            mli = i;
        end
    end
    %res  = [mli ml];
    res = ps;
end