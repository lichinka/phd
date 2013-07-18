data = load('D:\_PAPERS\$ Konference\2012-06 AAMAS\paper\graphs\data-test.txt');

MODE = 1;

ax = [5:5:25];

if MODE == 0
% F-MEASURE
     %    k=5   k=10   k=15   k=20   k=25
a = [   0.350, 0.530, 0.560, 0.580, 0.570;  % k-rule
        0.580, 0.693, 0.75, 0.78, 0.79;  % naive bayes
        0.590, 0.649, 0.74, 0.73, 0.75;  % HMMs
        0.650, 0.783, 0.840, 0.860, 0.87;  % UPR
        0.740, 0.905, 0.925, 0.930, 0.932]; % F-UPR
else
% PRECISION
     %    k=5   k=10   k=15   k=20   k=25
a = [   0.100, 0.202, 0.240, 0.260, 0.270;  % k-rule
        0.316, 0.436, 0.48, 0.53, 0.54;  % naive bayes
        0.210, 0.286, 0.29, 0.300, 0.310;  % HMMs
        0.34, 0.477, 0.49, 0.52, 0.53  % UPR
        0.45, 0.539, 0.56, 0.56, 0.565]; % F-UPR
end
    
%a = [a; log(a)./5.3; log(a)./3.8; log(a)./4.3; log(a)./3.7; log(a)./3.3]';
colors = {'c--*', 'g-.+', 'k--x', 'r--', 'b-'};


hold;
for i=1:5
    p = plot(ax, a(i,:), colors{i});
    set(p,'LineWidth',5);
    set(p,'MarkerSize',15);
end

if MODE == 0
    legend('\exists k rule', 'naive Bayes', 'HMMs', 'UPR', 'F-UPR', 'Location','SouthEast');
    legend('boxoff');
end

set(gca, 'FontName', 'Times New Roman');
set(gca, 'FontSize', 30);
set(gca,'XTick',[5:5:25]);
set(gca,'YTick',[0:0.25:1]);
xlim([5 25]);
ylim([0 1]);

xlabel(gca, '# of authorities');
if MODE == 0
    ylabel(gca, 'f-measure');
    print -depsc -tiff 'D:\_PAPERS\$ Konference\2012-06 AAMAS\paper\graphs\authvar-fm.eps';
else
    ylabel(gca, 'precision');
    print -depsc -tiff 'D:\_PAPERS\$ Konference\2012-06 AAMAS\paper\graphs\authvar-pr.eps';
end

