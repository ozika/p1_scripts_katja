load('f4.mat');
pstr = {'acquisition', 'extinction'};
half = {'FirstHalf', 'SecondHalf'};
cstr = {'harm', 'safe', 'reversal'};
load('anxiety_scores_final_set.mat');
D =[];
for c = 1:3
    for h = 1:2

        for ph = 1:2
            id = find_multiple_strings_in_cell(DATA.Properties.VariableNames, {pstr{ph}, cstr{c}, half{h}});
            d(:, h,ph,c)=table2array(DATA(:,id));
         
        end
    end
end
[tbl, rm] = simple_mixed_anova(d, [], {'Half', 'Phase', 'Cue'});
disp(tbl);

cols = [[0.6 0.1 0.1]; [0.2 0.3 0.6];[0 0 0]];
cuestr = {'Harmful Cue', 'Safe Cue', 'Reversal Cue'};
f=figure;
for c = 1:3
    da= squeeze(d(:,:,:,c));
    [tbl, rm] = simple_mixed_anova(da, [], {'Half', 'Phase'});
    disp(tbl);
    [tbl, rm] = simple_mixed_anova(da, anx_scores.TraitAnxBinary, {'Half', 'Phase'}, {'anxiety'});
    disp(tbl);
    
      disp('phase info')
     mean(mean(da,2) , 'omitnan')
        std(mean(da,2), 'omitnan')
        
        disp('half info')
     mean(mean(da,3) , 'omitnan')
        std(mean(da,3), 'omitnan')
    %post-hoc half
    for h =1:2
        g=[];
      
        
        disp([cuestr{c} ' half ' num2str(h) ])
        g = squeeze(da(:,h,:));
       
        [ha, p, ci, stats] = ttest(g(:,1), g(:,2));
    end
    disp('--------')
    for ph =1:2
        g=[];
        disp([cuestr{c} ' ' pstr{ph} ])
        g = squeeze(da(:,:,ph));

       
        [ha, p, ci, stats] = ttest(g(:,1), g(:,2));
        
    end
    
    
    
    subplot(1,3,c);
    
    me =squeeze(mean(da));
    err=squeeze(std(da)./sqrt(size(da,1)));
    e=errorbar([1 1; 2 2], me, err, 'LineWidth', 1.2, 'Color', cols(c,:));
    e(2).Color = cols(c,:) +0.3;
    ylim(([0 1.15]))
    xlim([0.5 2.5]);
    legend('Acquisition', 'Extinction');
    t=gca;
    t.XTick =[1 2];
    t.XTickLabels ={'First Half', 'Second Half'};
    t.XTickLabelRotation = 20;
    title(cuestr{c}, 'interpreter', 'latex')
end


f.Position(4) = 300;
f.Position(3) = 700;



%%anxiety post-hoc
 g = squeeze(mean(squeeze(d(:,:,:,3)),3));
for h = 1:2
    disp(['Half ' num2str(h)]);
   [h,p,ci,stats] =ttest2(g(find(anx_scores.TraitAnxBinary==1), h), g(find(anx_scores.TraitAnxBinary==2), h) );
end

f=figure;
hold on 
dlow= squeeze(d(find(anx_scores.TraitAnxBinary==1),:,:,3));
dhi= squeeze(d(find(anx_scores.TraitAnxBinary==2),:,:,3));
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
ylim([0 1.3]);
xlim([0.5 2.5]);
t=gca;
t.XTick=[1 2];
halfstr ={'First Half', 'Second Half'};
t.YTick =[0:0.25:1];
t.XTickLabels = halfstr;
t.XTickLabelRotation=20;

plot([0 3], [0.25 0.25], 'LineStyle', ':', 'Color', [0.8 0.8 0.8])
plot([0 3], [0.75 0.75], 'LineStyle', ':', 'Color', [0.8 0.8 0.8])
f.Position(3) = 500;
f.Position(4) = 450;
ylabel('Mean Subjective Probability');
title('Reversal Cue by Anxiety, Half, and Phase', 'Interpreter','latex')
legend({'Acquisition: High Anx', 'Extinction: High Anx', 'Acquisition: Low Anx', 'Extinction: Low Anx'}, 'location', 'northwest');;