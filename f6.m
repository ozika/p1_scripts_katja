load('f6.mat');
for o = 1:2
    for h = 1:2
    for ph = 1:2
                id = find_multiple_strings_in_cell(DATA.Properties.VariableNames, {pstr{ph} ostr{o}, half{h}});
                d(:, h,ph,o)=table2array(DATA(:,id));
    end
         
       
    end
end
[tbl, rm] = simple_mixed_anova(d,[], {'Half', 'Phase', 'Outcome'});
disp(tbl);
da = squeeze(mean(d, 4));
[tbl, rm] = simple_mixed_anova(da,anx_scores.TraitAnxBinary, {'Half', 'Phase'}, {'anxiety'});
disp(tbl);
%half*outcome interaction 
%marginalize phase 
da = squeeze(mean(d,3));
disp('1st sh vs 2nd half sh')
[h, p, ci, st]  =ttest(da(:,1,1), da(:,2,1));
disp('1st nosh vs 2nd half nosh')
[h, p, ci, st]  =ttest(da(:,1,2), da(:,2,2));
disp('1st sh vs nosh')
[h, p, ci, st]  =ttest(da(:,1,1), da(:,1,2));
disp('2nd sh vs nosh')
[h, p, ci, st]  =ttest(da(:,2,1), da(:,2,2));

%post-hoc for phase*outcome
%marginalize outcome 
da = squeeze(mean(d,2));
disp('acq sh ext sh')
[h, p, ci, st]  =ttest(da(:,1,1), da(:,2,1));
disp('acq nosh ext nosh')
[h, p, ci, st]  =ttest(da(:,1,2), da(:,2,2));
disp('acq sh acq nosh')
[h, p, ci, st]  =ttest(da(:,1,1), da(:,1,2));
disp('ext sh ext nosh')
[h, p, ci, st]  =ttest(da(:,2,1), da(:,2,2));

[tbl, rm] = simple_mixed_anova(d, anx_scores.TraitAnxBinary, {'Half', 'Phase', 'Outcome'}, {'Anxiety'});
disp(tbl);




cols = [0.7 0.3 0.3; 0.3 0.3 0.3];
f=figure;
    for ph = 1:2
        da = d(:, :,:,:);
        mhi = squeeze(mean(da(:,:,ph,:), 'omitnan'));
        ehi = squeeze(std(da(:,:,ph,:), 'omitnan')./sqrt(size(da,1)));
        e=errorbar([1 1; 2 2], mhi, ehi,  'LineWidth', 1.2);
        e(1).Color =cols(1,:)+(ph-1)*0.29;
        e(2).Color = cols(2,:)+(ph-1)*0.29;
    hold on 
    end
    
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
    title('Learning Change Over Time', 'Interpreter','latex')
    legend({'Shock: Acquisition', 'No-Shock: Acquisition', 'Shock: Extinction', 'No-Shock: Extinction'}, 'location', 'northwest');;