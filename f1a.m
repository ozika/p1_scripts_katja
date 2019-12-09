load('f1a.mat')
visualize_data_averages;
f=gcf;
D = [DATA.harm; DATA.safe; DATA.reversal];
M=[];
o =length(subIDs);
for p = 1:length(subIDs)
    M(p) = 1;
    M(p+length(subIDs)) = 2;
    M(p+(length(subIDs)*2)) = 3;
end
s = scatter(M(1:o), D(1:o)); 
hold on
s2=scatter(M((o+1):(o*2)), D((o+1):(o*2))); 
s3=scatter(M(((o*2)+1):o*3), D(((o*2)+1):o*3));
[s.MarkerEdgeColor s2.MarkerEdgeColor s3.MarkerEdgeColor] = deal([0 0 0]);
s.MarkerFaceColor = pink; 
s2.MarkerFaceColor = brick; 
s3.MarkerFaceColor = purple; 

p6040_x = 0:1:4;
p90 = [0.9 0.9 0.9 0.9 0.9];
p75 = [0.75 0.75 0.75 0.75 0.75];
p60 = [0.6 0.6 0.6 0.6 0.6];
p50 = [0.5 0.5 0.5 0.5 0.5];
p40 = [0.4 0.4 0.4 0.4 0.4];
p25 = [0.25 0.25 0.25 0.25 0.25];
p10 = [0.1 0.1 0.1 0.1 0.1];


plot(p6040_x, p75, '--', 'Color', pink);
plot(p6040_x, p50, '--', 'Color', purple);
plot(p6040_x, p25, '--', 'Color', brick);



h(1).FaceColor = grey;

xlim([0.5 3.5]);
ylim([0,1.1]);
set(gca,'XTicklabel', {'Harmful', 'Safe', 'Reversal', ''});
yl =ylabel('Subjective Probability');
[t.FontName, yl.FontName] = deal(spec.font_name);
plot_significance([1 2; 2 3; 1 3], [0.99 0.84 1.05], [3 3 3] )

f.Position(3) =400;
f.Position(4) = 600;
l.Visible ='off';  
t=title('Mean Shock Probability by Cue');
[t.FontName] = deal(spec.font_name);
t=gca;
t.YTick = [0:0.25:1];