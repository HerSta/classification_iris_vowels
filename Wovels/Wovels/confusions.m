%confusions
targets = gentarget(peak_data);
outputs = genoutputs(peak_data);
[c,cm,ind,per] = confusion(targets,outputs);
plotconfusion(targets,outputs,'Wovel classification with features f1, f2, f3');
[cb,cmb,indb,perb] = confusion(targets,genbadoutput(peak_data));
