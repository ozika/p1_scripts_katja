load('f14.mat');

%AIC.(8) = surp4.LR_DATA{3}.AIC;
AIC.Properties.VariableNames = mn;
h = table2array(AIC(:,2:numel(M)+1));
mAIC = mean(h, 'omitnan')
h=[h;mAIC];
for s = 1:size(h,1)
    r = h(s,:);
    for c = 1:length(r)
        p(s, find(r ==min(r))) = c;
        r(find(r==min(r))) =1000;
    end
end
t_f = figure;
t_f.Position(3) = 500;
t_f.Position(4) = 600;

t = heatmap(p);
colormap bone %bone
%t.XDisplayLabels = {'RW1', 'RW2', 'RW4_DecGrowth', 'PH6_Decay', 'StSw5', 'Surprise'};
t.XDisplayLabels = { 'Rescorla-Wagner','Pearce-Hall', 'Alpha Decay',  'State Switching'};

set(t, 'ColorbarVisible', 'off')
t.XLabel = {'Model Name'};
t.YLabel = {'Subject'};
t.YDisplayLabels{29} = 'Overall Rank';
title({['Model Comparison: Within-Subject AIC Ranking'], ['[1 - Best; 5 - Worst]']});
save('modelcomp_aic.mat', 'p');

sbs =1:28;
rw6bigger = find(p(sbs,2) < p(sbs,4));
stst5bigger = find(p(sbs,2) > p(sbs,4));
rw6bigger = find(p(sbs,4) ~= 1);
stst5bigger = find(p(sbs,4) == 1);
d(1) = mean(anx_scores.TraitAnx(rw6bigger), 'omitnan')
err(1) = stderror(anx_scores.TraitAnx(rw6bigger));
d(2) = mean(anx_scores.TraitAnx(stst5bigger), 'omitnan')
err(2) = stderror(anx_scores.TraitAnx(stst5bigger));
strat(find(p(sbs,4) ~= 1)) = 1;
strat(find(p(sbs,4) == 1)) = 2;

[hh,pp,ci,stats] =ttest2(anx_scores.TraitAnx(rw6bigger),anx_scores.TraitAnx(stst5bigger) )
f=figure;
b=bar(d', 'FaceColor', [0.4 0.1 0.4]);

hold on 
errorbar([1 2], d, err, 'LineStyle', 'none', 'Color',[0 0 0])
t=gca;
t.XTickLabels={'Other Model', 'State Switcher'};
ylabel('Trait Anxiety');
ylim([0 60])
sc=text(1.47, 55, '**');

plot([1 2], [53 53], 'Color', [0 0 0]);
xlim([0.3 2.7]);
f.Position(3) = 300;
f.Position(4) = 400;


f=figure;
bar(mAIC, 'FaceColor', [0.1 0.1 0.3])
ylim([-412 -310])
ylabel('Mean AIC Score');
hold on 
h(29,:)=[];
p(29,:)=[];
 for m = 1:4
        B( m) = length(find(p(:,m)==1));
       text(m-0.15, mAIC(m)-3, [num2str(B(m))]);
    end
    t=gca;
    t.XTickLabels = { 'RW2', 'PH6','RW4-DG',  'StSw5'};
    t.XTickLabelRotation =20;
    text(0,-405, {['* digit below each column represents number of best fitted participant'], ['by the respective model']})