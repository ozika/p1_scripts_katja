load('f10.mat');

cols = [0.9 0.3 0.3; 0.3 0.3 0.3];
f=figure;
mhi = squeeze(mean(d));
ehi = squeeze(std(d)./sqrt(size(d,1)));
e=errorbar([1 1; 2 2], mhi, ehi,  'LineWidth', 1.2);
e(1).Color =cols(1,:);
e(2).Color = cols(2,:);

ylim([0 0.6]);
xlim([0.5 2.5]);
t=gca;
t.XTick=[1 2];
halfstr ={'First Half', 'Second Half'};
t.YTick =[0:0.25:1];
t.XTickLabels = halfstr;
t.XTickLabelRotation=20;


f.Position(3) = 500;
f.Position(4) = 450;
ylabel('Model-Free Learning Rate');
title('No-Shock Learning Change Over Time', 'Interpreter','latex')
legend(ostr, 'location', 'northwest');;
[tbl, rm] = simple_mixed_anova(d, anx_scores.TraitAnxBinary, {'Half', 'Outcome'}, {'Anxiety'});
disp(tbl);
[tbl, rm] = simple_mixed_anova(d, anx_scores.TraitAnxBinary, {'Half', 'Outcome'}, {'Anxiety'});
disp(tbl);


da = squeeze(mean(d,2));
loa = find(anx_scores.TraitAnxBinary==1);
hia  = find(anx_scores.TraitAnxBinary==2);
nd = da(:,1) - da(:,2);
[h,p,c,st]= ttest2(nd(loa), nd(hia));
mean(da(loa,:))
mean(da(hia,:))
disp('hi vs lo in shock')
[h, p, ci, st]  =ttest2(da(loa,1), da(hia,1));
disp('hi vs lo in noshock')
[h, p, ci, st]  =ttest2(da(loa,2), da(hia,2));
disp('hi vs hi in shock/nosh')
[h, p, ci, st]  =ttest(da(hia,1), da(hia,2));
disp('lo vs lo in shock/nosh')
[h, p, ci, st]  =ttest(da(loa,1), da(loa,2));




f=figure;
hold on 
dlow=[];
dhi =[];
dlow= d(find(anx_scores.TraitAnxBinary==1),:,:);
dhi= d(find(anx_scores.TraitAnxBinary==2),:,:);
l = [0.1 0.3; 0.2 0.4];
cols = [[0.6 0.1 0.1]; [0.2 0.3 0.6];[0 0 0]];
for ph = 1:2
    for h = 1:2
        q=[];
         q = squeeze(dlow(:,h,ph));
        for i = 1:size(q)
           s=scatter(h+(l(1,ph)+rand*0.02)*(h-1.5), q(i), 10, cols(ph,:) , 'HandleVisibility','off');
            
        end
        
        q=[];
         q = squeeze(dhi(:,h,ph));
        for i = 1:size(dhi,1)
            s=scatter(h+(l(2,ph)+rand*0.02)*(h-1.5), q(i), 10, cols(ph,:)+0.4, 'HandleVisibility','off');
        end
    end
end

mlow = squeeze(mean(dlow));
mhi = squeeze(mean(dhi));
elow = squeeze(  std(dlow)./sqrt(size(dlow,1)));
ehi = squeeze(std(dhi)./sqrt(size(dhi,1)));
e=errorbar([1 1; 2 2], mhi, ehi,  'LineWidth', 1.2);
e(1).Color =cols(1,:)+0.4;
e(2).Color = cols(2,:)+0.4;
hold on 
e=errorbar([1 1; 2 2], mlow, elow, 'LineWidth', 1.2);
e(1).Color =cols(1,:);
e(2).Color = cols(2,:);
ylim([0 0.8]);
xlim([0.5 2.5]);
t=gca;
t.XTick=[1 2];
halfstr ={'First Half', 'Second Half'};
t.YTick =[0:0.25:1];
t.XTickLabels = halfstr;
t.XTickLabelRotation=20;


f.Position(3) = 500;
f.Position(4) = 450;
ylabel('Model-Free Learning Rate');
title('Reversal Cue by Anxiety, Half, and Outcome', 'Interpreter','latex')
legend({'Shock: High Anx', 'No-Shock: High Anx', 'Shock: Low Anx', 'No-Shock: Low Anx'}, 'location', 'northwest');;