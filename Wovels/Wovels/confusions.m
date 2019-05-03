%confusions
half = 1;
good_len = 92;
order = 2;

optimal = 8991;
%optimal = 15;

targets = gentarget(peak_data,half,good_len);
outputs = genoutputs(peak_data,half,good_len);
gmm_out = gmmoutputs(peak_data,half,good_len,order);

next = 1;
test_F = zeros(12,1,139);
for j = 1:15
    if(mod(floor(optimal/2^(j-1)),2))
        test_F(:,next,:) = peak_data(:,j,:);
        next = next+1;
    end
end

optimaloutput = genoutputs(test_F,half,good_len);

sub_opt_gmm_out = gmmoutputs(test_F,half,good_len,order);

optimalc = confusion(targets,optimaloutput);

%badoutputs = genbadoutput(peak_data,half,good_len);
ttargets = gentarget(peak_data,~half,good_len);
toutputs = genoutputs(peak_data,~half,good_len);
tgmm_out = gmmoutputs(peak_data,~half,good_len,order);
%tbadoutputs = genbadoutput(peak_data,~half,good_len);

[c,cm,ind,per] = confusion(targets,outputs);
plotconfusion(targets,sub_opt_gmm_out,'Wovel classification with features f1, f2, f3');
[cb,cmb,indb,perb] = confusion(targets,badoutputs);
[ct,cmt,indt,pert] = confusion(ttargets,toutputs);
[cbt,cmbt,indbt,perbt] = confusion(ttargets,tbadoutputs);
py_target = genplottarget(peak_data,half,good_len);
%py_out = genplotoutputs(peak_data,half,good_len);

