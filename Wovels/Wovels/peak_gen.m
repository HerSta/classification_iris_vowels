%Class mean
peak_data = zeros(12,3,139);
next = ones(12);
[length,dontcare] = size(filenames);
for i=1:length
    if(F1s(i)*F2s(i)*F3s(i)~=0)%Removing bad data
        peak_data(vowel_code(i),1,next(vowel_code(i)))=F1s(i);
    
        peak_data(vowel_code(i),2,next(vowel_code(i)))=F2s(i);
    
        peak_data(vowel_code(i),3,next(vowel_code(i)))=F3s(i);
        
        next(vowel_code(i))=next(vowel_code(i))+1;
        
    end
end

