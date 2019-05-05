%Decoding data
% character 1:     m=man, w=woman, b=boy, g=girl
% characters 2-3:  talker number
% characters 4-5:  vowel (ae=”had”, ah=”hod”, aw=”hawed”, eh=”head”,
%    er=”heard”, ei=”haid”, ih=”hid”, iy=”heed”, oa=/o/ as in “boat”, 
%    oo=”hood”, uh=”hud”, uw=”who’d”) 

[files,dur,F0s,F1s,F2s,F3s,F4s,F120,F220,F320,F150,F250,F350,F180,F280,F380] = textread('vowdata_nohead.dat','%s%4.1f%4.1f%4.1f%4.1f%4.1f%4.1f%4.1f%4.1f%4.1f%4.1f%4.1f%4.1f%4.1f%4.1f%4.1f'); 

vowel = str2mat('ae','ah','aw','eh','er','ei','ih','iy','oa','oo','uh','uw');
talker_group = str2mat('m','w','b','g');
filenames=char(files); % convert cell array to character matrix
[nfiles,nchar]=size(filenames); 
for ifile=1:nfiles
    vowel_code(ifile) = strmatch(filenames(ifile,4:5),vowel);
    talker_group_code(ifile) = strmatch(filenames(ifile,1),talker_group);
    talker_number(ifile) = str2num(filenames(ifile,2:3));
end
%Storing data in new format
features = 15; %Number of features used.
peak_data = zeros(12,features,139); %Datastructure for storing feature values for all classes.
next = ones(12);
[length,dontcare] = size(filenames);
for i=1:length
    if(dur(i)*F0s(i)*F120(i)*F150(i)*F180(i)*F1s(i)*F220(i)*F250(i)*F280(i)*F2s(i)*F320(i)*F350(i)*F380(i)*F3s(i)*F4s(i)~=0)%Removing bad data
        feature_list = [dur(i) F0s(i) F120(i) F150(i) F180(i) F1s(i) F220(i) F250(i) F280(i) F2s(i) F320(i) F350(i) F380(i) F3s(i) F4s(i)];
        peak_data(vowel_code(i),:,next(vowel_code(i)))=feature_list(1:features);
        next(vowel_code(i))=next(vowel_code(i))+1; 
    end
end
