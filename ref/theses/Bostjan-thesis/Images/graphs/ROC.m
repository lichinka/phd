
files = {'k-rule', 'bayes', 'hmm', 'upr', 'espy'};
hold;
colors = {'c--*', 'g-.+', 'k--x', 'r--', 'b-'};
for i=1:length(files)
    
data = load([files{i}, '.mat']);

xt = data.y(:,1)-min(data.y(:,1));
x = xt./max(xt);
y1 = data.y(:,2);
y2 = data.y(:,3);

p = plot(1-y2, y1, colors{i})
set(p,'LineWidth',3);
set(p,'MarkerSize',10);
end

%p = plot([0:0.1:1], [0:0.1:1], 'k--');

legend('\exists k rule', 'naive Bayes', 'HMMs', 'UPR', 'F-UPR', 'Location','SouthEast');
legend('boxoff');


set(gca, 'FontName', 'Times New Roman');
set(gca, 'FontSize', 30);
set(gca,'XTick',[0 0.50 1.00]);
set(gca,'YTick',[0 0.50 1.00]);

xlabel(gca, 'FP Rate (1-specificity)');
ylabel(gca, 'TP Rate (recall)');

print('-depsc',  '-tiff',  ['D:\_PAPERS\$ Konference\2012-06 AAMAS\paper\graphs\ROC.eps']);