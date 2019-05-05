function test_F = feature_extract(peak_data,F)
    next = 1;
    test_F = zeros(12,1,139);
    for j = 1:15
        if(mod(floor(F/2^(j-1)),2))%Decode feature code F
            test_F(:,next,:) = peak_data(:,j,:);
            next = next+1;
        end
    end
end