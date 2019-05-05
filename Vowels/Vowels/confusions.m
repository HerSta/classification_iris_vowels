%confusions
half = 1;
good_len = 92;
order = 2;
optimal = 8991;

targets = gentarget(peak_data,half,good_len);
outputs = genoutputs(peak_data,half,good_len);
gmm_out2 = gmmoutputs(peak_data,half,good_len,2);
gmm_out3 = gmmoutputs(peak_data,half,good_len,3);



next = 1;
test_F = zeros(12,1,139);
for j = 1:15
    if(mod(floor(optimal/2^(j-1)),2))
        test_F(:,next,:) = peak_data(:,j,:);
        next = next+1;
    end
end

optimaloutput = genoutputs(test_F,half,good_len);
optimal_output_training = gen_training_set_outputs(test_F,half,good_len);
interchanged_optimal_output = genoutputs(test_F,~half,good_len);

gmm_out2 = gmmoutputs(test_F,half,good_len,2);
gmm_out3 = gmmoutputs(test_F,half,good_len,3);

%sub_opt_gmm_out = gmmoutputs(test_F,half,good_len,order);

optimalc = confusion(targets,optimaloutput);

badoutputs = genbadoutput(peak_data,half,good_len);
ttargets = gentarget(peak_data,~half,good_len);
toutputs = genoutputs(peak_data,~half,good_len);
tgmm_out = gmmoutputs(peak_data,~half,good_len,order);
tbadoutputs = genbadoutput(peak_data,~half,good_len);

training_set_output = gen_training_set_outputs(peak_data,half,good_len);
bad_training_set_output = gen_bad_training_set_output(peak_data,half,good_len);

[c,cm,ind,per] = confusion(targets,outputs);
%plotconfusion(targets,sub_opt_gmm_out,'Wovel classification with features f1, f2, f3');
[cb,cmb,indb,perb] = confusion(targets,badoutputs);
[ct,cmt,indt,pert] = confusion(ttargets,training_set_output);
[cbt,cmbt,indbt,perbt] = confusion(ttargets,tbadoutputs);

%py_target = genplottarget(peak_data,half,good_len);
%py_out = genplotoutputs(peak_data,half,good_len);

py_target1 = smartgenplot(targets);
py_target2 = smartgenplot(ttargets);
py_out = smartgenplot(outputs);
py_out_t = smartgenplot(training_set_output);
py_bad_out = smartgenplot(badoutputs);
py_bad_out_t = smartgenplot(bad_training_set_output);
py_gmm2 = smartgenplot(gmm_out2(1:12,:));
py_gmm3 = smartgenplot(gmm_out3(1:12,:));

save('py_out_data.mat','py_out');
save('py_out_t_data.mat','py_out_t');
save('py_bad_out_data.mat','py_bad_out');
save('py_bad_out_t_data.mat','py_bad_out_t');
save('py_target1_data.mat','py_target1');
save('py_target2_data.mat','py_target2');
save('py_gmm2_data.mat','py_gmm2');
save('py_gmm3_data.mat','py_gmm3');


agmm2 = 1-confusion(targets,gmm_out2(1:12,:))
agmm2t = 1-confusion(targets,gmm_out2(13:24,:))
agmm3 = 1-confusion(targets,gmm_out3(1:12,:))
agmm3t = 1-confusion(targets,gmm_out3(13:24,:))

accuracy_of_optimal_model = 1-confusion(targets,optimaloutput)
accuracy_of_optimal_model_training = 1-confusion(ttargets,optimal_output_training)
accuracy_of_optimal_model_interchanged = 1-confusion(ttargets,interchanged_optimal_output)

accuracy_of_full_test = 1-confusion(ttargets,training_set_output)


