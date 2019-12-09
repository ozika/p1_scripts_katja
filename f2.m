load('f2.mat');


d=[];
for c=1:3
        for o = 1:2
         
        
               
                    id = find_multiple_strings_in_cell(DATA.Properties.VariableNames, { ostr{o}, cstr{c}});
                    d(:, o,c)=table2array(DATA(:,id));
                 
              
            
        end
        disp(cstr{c});
        [tbl, rm] = simple_mixed_anova(squeeze(d(:,:,c)), [], {'Outcome'});
        disp(tbl);
end
da = squeeze(mean(d,1));
err = squeeze(std(d,1))./sqrt(size(d,1));
f=figure;
b=bar(da');
b(1).FaceColor = [0.9 0.6 0.1];
b(2).FaceColor = [0.6 0.6 0.6];
hold on 
e=errorbar([[1 2 3]-0.15; [1 2 3]+0.15]', da',err', 'LineStyle', 'none', 'Color', [0 0 0]);
t=gca;
t.XTickLabels = cuestr;

ylabel('Model-free Learning Rate');
f.Position(3) =400;
ylim([0 0.57])
plot_significance([0.8 1.2; 1.8 2.2; 2.8 3.2], [0.45 0.45 0.45], [3 3 3], 0.02 );
legend(shockstr);

load('f2b.mat');
cues = {'harm', 'safe', 'reversal'};
d=[];
for c=1:3
        for o = 1:2
            for ph = 1:2
         
        
               
                id = find_multiple_strings_in_cell(DATA.Properties.VariableNames, {pstr{ph}, ostr{o}, cstr{c}});
                d(:,ph, o,c)=table2array(DATA(:,id));
                 
            end
            
        end
        disp(cstr{c});
        [tbl, rm] = simple_mixed_anova(squeeze(d(:,:,:,c)), [], {'Phase', 'Outcome'});
        disp(tbl);
        tbl= rid_table_of_rownames(tbl);
        writetable(tbl, ['mflr_phase_outcome_' cues{c} '.csv'])
        %main effect of outcome
        da =squeeze(d(:,:,:,c));
        sh = mean(da(:,:,1),2);
        nosh = mean(da(:,:,2),2);
        disp('shnosh')
        mean(sh, 'omitnan')
        std(sh, 'omitnan')
        mean(nosh, 'omitnan')
        std(nosh, 'omitnan')
        disp('acqet')
        acq = mean(da(:,1,:),3);
        ext= mean(da(:,2,:),3);
        mean(acq, 'omitnan')
        std(acq, 'omitnan')
        mean(ext, 'omitnan')
        std(ext, 'omitnan')
        
        disp('acq sh')
        mean(da(:,1,1), 'omitnan')
        std(da(:,1,1), 'omitnan')
        disp('acq nosh')
        mean(da(:,1,2), 'omitnan')
        std(da(:,1,2), 'omitnan')
         disp('ext sh')
        mean(da(:,2,1), 'omitnan')
        std(da(:,2,1), 'omitnan')
        disp('ext nosh')
        mean(da(:,2,2), 'omitnan')
        std(da(:,2,2), 'omitnan')
        % 
        disp('shock acq ext')
        [h,p,ci,stats] =ttest(da(:,1,1), da(:,2,1));
        disp('noshock acq ext')
        [h,p,ci,stats] =ttest(da(:,1,2), da(:,2,2));
        disp('acq sh nosh')
        [h,p,ci,stats] =ttest(da(:,1,1), da(:,1,2));
        disp('ext sh nosh')
        [h,p,ci,stats] =ttest(da(:,2,1), da(:,2,2));
        
end
  f=figure;
  sig1  = [3 3; 3 2; 3 3];
  sig2 = [0 1; 0 0 ; 1 3];
for c = 1:3
  subplot(3,1,c);
        
        
    
    da = squeeze(mean(squeeze(d(:,:,:,c)),1, 'omitnan'));
    err = squeeze(std(squeeze(d(:,:,:,c)),1, 'omitnan'))./sqrt(size(d,1));
    
    b=bar(da);
    b(1).FaceColor = [0.9 0.6 0.6];
    b(2).FaceColor = [0.6 0.6 0.6];
    hold on 
    e=errorbar([[1 2]-0.15; [1 2 ]+0.15]', da,err, 'LineStyle', 'none', 'Color', [0 0 0]);
    t=gca;
    t.XTickLabels = phasestr;
    if c==2
    ylabel('Model-free Learning Rate');
    end

    
        ylim([0 0.9])
    
    plot_significance([0.8 1.2; 1.8 2.2], [0.52 0.52], sig1(c,:), 0.02 );
    plot_significance([0.8 1.8; 1.2 2.2], [0.6 0.7], sig2(c,:), 0.02 );
    if c ==1
    legend(shockstr, 'Location','northwest');
    end
    title(cuestr{c}, 'interpreter', 'latex')
    g=[];
     g = squeeze(d(:,:,:,c));
    for ph = 1:2
        dd =[];
        dd=squeeze(g(:,ph,:));
        disp([cuestr{c} ' ' phasestr{ph}]);
       [h,p,ci,stats] =ttest(dd(:,1), dd(:,2));
    end
    disp('by outcome')
    for o = 1:2
        dd =[];
        dd=squeeze(g(:,:,o));
        disp([cuestr{c} ' ' ostr{o}]);
       [h,p,ci,stats] =ttest(dd(:,1), dd(:,2));
    end
end

f.Position(3) = 300;
f.Position(4) = 800;