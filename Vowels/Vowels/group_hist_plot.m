x = F0s(find(talker_group_code==1));
figure(1);
subplot(221);
hist(x,20);% use 20 “bins”
set(gca,'XLim',[50 500]); % set x-axis limits between 50 & 500 Hz
title('adult males'); 