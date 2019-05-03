%paramtest
half = 1;
good_len = 92;
targets = gentarget(peak_data,half,good_len);
c_min = 1; %Minimum confusion found so far
i_min = -1; %Parameter set giving minimum confusion
paramstats = zeros(2^15-1,1); %Confusion of all possible parameter sets
for i = 1:2^15-1
    next = 1;
    test_F = zeros(12,1,139);
    for j = 1:15
        if(mod(floor(i/2^(j-1)),2)) %Extracting relevant parameters
            test_F(:,next,:) = peak_data(:,j,:); %And storing them in test_F
            next = next+1;
        end
    end
    outputs = genoutputs(test_F,half,good_len); %Classifying targets based on the data in test_F
    c = confusion(targets,outputs); %Calculating confusionrate of the single gauss classifier based on test_F
    paramstats(i) = c; %Storing the result
    if(c<c_min)
        c_min = c
        i_min = i
    end
end
