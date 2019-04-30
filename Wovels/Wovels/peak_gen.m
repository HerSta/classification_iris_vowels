%Class mean
features = 15;
peak_data = zeros(12,features,139);
next = ones(12);
[length,dontcare] = size(filenames);
for i=1:length
    if(dur(i)*F0s(i)*F120(i)*F150(i)*F180(i)*F1s(i)*F220(i)*F250(i)*F280(i)*F2s(i)*F320(i)*F350(i)*F380(i)*F3s(i)*F4s(i)~=0)%Removing bad data
        feature_list = [dur(i) F0s(i) F120(i) F150(i) F180(i) F1s(i) F220(i) F250(i) F280(i) F2s(i) F320(i) F350(i) F380(i) F3s(i) F4s(i)];
        peak_data(vowel_code(i),:,next(vowel_code(i)))=feature_list(1:features);
        next(vowel_code(i))=next(vowel_code(i))+1; 
    end
end

