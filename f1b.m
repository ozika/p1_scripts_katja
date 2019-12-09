load('f1b.mat');
visualize_data_averages;
f=gcf;
D = [DATA.harm_acquisition; DATA.safe_acquisition; DATA.reversal_acquisition; DATA.harm_extinction; DATA.safe_extinction; DATA.reversal_extinction];
M=[];
o =length(subIDs);
for p = 1:length(subIDs)
    M(p) = 0.78;
    M(p+length(subIDs)) = 1;
    M(p+(length(subIDs)*2)) = 1.22;
    M(p+(length(subIDs)*3)) = 1.78;
    M(p+(length(subIDs)*4)) = 2;
    M(p+(length(subIDs)*5)) = 2.22;
end
s = scatter(M(1:o), D(1:o)); 
hold on
s2=scatter(M((o+1):(o*2)), D((o+1):(o*2))); 
s3=scatter(M(((o*2)+1):o*3), D(((o*2)+1):o*3));
s4=scatter(M(((o*3)+1):o*4), D(((o*3)+1):o*4));
s5=scatter(M(((o*4)+1):o*5), D(((o*4)+1):o*5));
s6=scatter(M(((o*5)+1):o*6), D(((o*5)+1):o*6));
[s.MarkerEdgeColor s2.MarkerEdgeColor s3.MarkerEdgeColor s4.MarkerEdgeColor s5.MarkerEdgeColor s6.MarkerEdgeColor] = deal([0 0 0]);
s.MarkerFaceColor = pink_g3; 
s2.MarkerFaceColor = brick_g3; 
s3.MarkerFaceColor = purple_g3; 
s4.MarkerFaceColor = pink_g3; 
s5.MarkerFaceColor = brick_g3; 
s6.MarkerFaceColor = purple_g3; 


p6040_x = 0:1:4;
p90 = [0.9 0.9 0.9 0.9 0.9];
p75 = [0.75 0.75 0.75 0.75 0.75];
p60 = [0.6 0.6 0.6 0.6 0.6];
p50 = [0.5 0.5 0.5 0.5 0.5];
p40 = [0.4 0.4 0.4 0.4 0.4];
p25 = [0.25 0.25 0.25 0.25 0.25];
p10 = [0.1 0.1 0.1 0.1 0.1];


plot(p6040_x, p75, '--', 'Color', pink);

plot(p6040_x, p25, '--', 'Color', brick);
h(1).FaceColor = pink_g3_light;
h(2).FaceColor = brick_g3_light;
h(3).FaceColor = purple_g3_light;
set(gca,'XTicklabel', {'Acquisition', 'Extinction'});
l = legend({'Harmful', 'Safe', 'Reversal'});
t=title('Mean Shock Probability by Phase and Cue');
yl =ylabel('Subjective Probability');
[t.FontName, yl.FontName, l.FontName] = deal(spec.font_name);

%plot_significance([0.78 1.78; 1 2; 1.22 2.22], [1.02 1.06 1.10], [3 0 3] )
ylim([0 1.2])

f.Position(3) =400;
f.Position(4) = 600;
l.Visible ='off';