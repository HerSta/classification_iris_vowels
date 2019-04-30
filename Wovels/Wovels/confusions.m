%confusions
half = 1;
good_len = 92;
targets = gentarget(peak_data,half,good_len);
outputs = genoutputs(peak_data,half,good_len);
badoutputs = genbadoutput(peak_data,half,good_len);
ttargets = gentarget(peak_data,~half,good_len);
toutputs = genoutputs(peak_data,~half,good_len);
tbadoutputs = genbadoutput(peak_data,~half,good_len);
[c,cm,ind,per] = confusion(targets,outputs);
plotconfusion(targets,outputs,'Wovel classification with features f1, f2, f3');
[cb,cmb,indb,perb] = confusion(targets,badoutputs);
[ct,cmt,indt,pert] = confusion(ttargets,toutputs);
[cbt,cmbt,indbt,perbt] = confusion(ttargets,tbadoutputs);
py_target = genplottarget(peak_data,half,good_len);
py_out = genplotoutputs(peak_data,half,good_len);