%confusions
half = 1;
targets = gentarget(peak_data,half);
outputs = genoutputs(peak_data,half);
[c,cm,ind,per] = confusion(targets,outputs);
plotconfusion(targets,outputs,'Wovel classification with features f1, f2, f3');
[cb,cmb,indb,perb] = confusion(targets,genbadoutput(peak_data,half));
py_target = genplottarget(peak_data,half);
py_out = genplotoutputs(peak_data,half);