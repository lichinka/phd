%a = load('D:\_PAPERS\$ Konference\2012-06 AAMAS\paper\graphs\data-test.txt')

files = {'k-rule', 'bayes', 'hmm', 'upr', 'espy'};

for i=1:length(files)
    
data = load([files{i}, '.mat']);

xt = data.y(:,1)-min(data.y(:,1));
x = xt./max(xt);
y1 = data.y(:,2);
y2 = data.y(:,3);


p = plot(x, 1-y1, 'b-', 'MarkerSize', 20);
hold;
set(p,'LineWidth',5)
p = plot(x, 1-y2, 'r--', 'MarkerSize', 20);
set(p,'LineWidth',5)
set(gca, 'FontName', 'Times New Roman');
set(gca, 'FontSize', 40);
%set(gca,'XTick',[0 0.25 0.50 0.75 1.00])
set(gca,'YTick',[0 0.25 0.50 0.75 1.00])

if i == 1
    legend('susp', 'norm', 'Location','SouthEast');
    legend('boxoff');
end

xlabel(gca, 'Threshold [%]');
ylabel(gca, 'Error [%]');

print('-depsc',  '-tiff',  ['D:\_PAPERS\$ Konference\2012-06 AAMAS\paper\graphs\', files{i}, '.eps']);
hold;
end
