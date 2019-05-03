%paramtest
targets = gentarget(peak_data,half,good_len);
c_min = 1;
i_min = -1;
params = 15;
paramstats = zeros(2^15-1,1);
for i = 1:2^15-1
    next = 1;
    test_F = zeros(12,1,139);
    for j = 1:params
        if(mod(floor(i/2^(j-1)),2))
            test_F(:,next,:) = peak_data(:,j,:);
            next = next+1;
        end
    end
    outputs = genoutputs(test_F,half,good_len);
    c = confusion(targets,outputs);
    paramstats(i) = c;
    if(c<c_min)
        c_min = c
        i_min = i
    end
end
