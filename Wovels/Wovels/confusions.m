%confusions
[c,cm,ind,per] = confusion(gentarget(peak_data),genoutputs(peak_data));
[cb,cmb,indb,perb] = confusion(gentarget(peak_data),genbadoutput(peak_data));