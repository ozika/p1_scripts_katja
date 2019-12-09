load('f7.mat');

d=[];
for c=1:3
        for o = 1:2
              for  h = 1:2
         
        
               
                    id = find_multiple_strings_in_cell(DATA.Properties.VariableNames, {half{h}, ostr{o}, cstr{c}});
                    d(:,h, o,c)=(table2array(DATA(:,id)));
                 
        end
            
        end
        disp(cstr{c});
        [tbl, rm] = simple_mixed_anova(squeeze(d(:,:,:,c)), [], {'Half', 'Outcome'});
        disp(tbl);
         [tbl, rm] = simple_mixed_anova(squeeze(d(:,:,:,c)), anx_scores.TraitAnxBinary, {'Half', 'Outcome'}, {'anxiety'});
        disp(tbl);
end
[tbl, rm] = simple_mixed_anova(d, [], {'Half', 'Outcome'});
        disp(tbl);
cols = [[0.6 0.1 0.1]; [0.2 0.3 0.6];[0 0 0]];
cuestr = {'Harmful Cue', 'Safe Cue', 'Reversal Cue'};
f=figure;
for c = 1:3
    da= squeeze(d(:,:,:,c));
  
    
    %post-hoc half
    for h =1:2
        g=[];

        disp([cuestr{c} ' half ' num2str(h) ])
        g = squeeze(da(:,h,:));
            [ha, p, ci, stats] = ttest(g(:,1), g(:,2));
    end
    disp('--------')
    for o =1:2
        g=[];
        disp([cuestr{c} ' ' ostr{o} ])
        g = squeeze(da(:,:,o));
        [ha, p, ci, stats] = ttest(g(:,1), g(:,2));
        
    end
        disp('===========')

    
    
    
    subplot(1,3,c);
    
    me =squeeze(mean(da, 'omitnan'));
    err=squeeze(std(da, 'omitnan')./sqrt(size(da,1)));
    e=errorbar([1 1; 2 2], me, err, 'LineWidth', 1.2, 'Color', cols(c,:));
    e(2).Color = cols(c,:) +0.3;
    ylim(([0 3]))
    xlim([0.5 2.5]);
    legend({'Negative Surprise', 'Positive Surprise'} );
    t=gca;
    t.XTick =[1 2];
    t.XTickLabels ={'First Half', 'Second Half'};
    t.XTickLabelRotation = 20;
    title(cuestr{c}, 'interpreter', 'latex')
    if  c == 1
        ylabel('Surprise');
    end
end

f.Position(3) = 750;

da= squeeze(d(:,:,:,3));

%post hocs for anxiety 
g=[];
g = squeeze(mean(da,3));
disp('lowanx')
disp(half)
mean(g(anx_scores.TraitAnxBinary==1,:))
disp('hianx')
disp(half)
mean(g(anx_scores.TraitAnxBinary==2,:))
for h = 1:2
    
disp(halfstr{h})
[h,p,ci,st] = ttest2(g(anx_scores.TraitAnxBinary==1,h), g(anx_scores.TraitAnxBinary==2,h))
end

g=[];
g = squeeze(mean(da,2));
disp('lowanx')
disp(ostr)
mean(g(anx_scores.TraitAnxBinary==1,:))
disp('hianx')
mean(g(anx_scores.TraitAnxBinary==2,:))
for o = 1:2
    
disp(ostr{o})
[h,p,ci,st] = ttest2(g(anx_scores.TraitAnxBinary==1,o), g(anx_scores.TraitAnxBinary==2,o))
end
for o = 1:2
    for h = 1:2
    
    disp([ostr{o} ' ' halfstr{h}])
    [h,p,ci,st] = ttest2(da(anx_scores.TraitAnxBinary==1,h,o), da(anx_scores.TraitAnxBinary==2,h,o))
    end
end


sh_min_nosh = da(:,:,1) - da(:,:,2)
[r,p] = corr(sh_min_nosh(:,1), anx_scores.TraitAnx)
[r,p] = corr(sh_min_nosh(:,2), anx_scores.TraitAnx)
f=figure;
for h = 1:2
    subplot(1,2,h)
    scatter( anx_scores.TraitAnx,sh_min_nosh(:,h), 20, [0 0 0 ], 'MarkerFaceColor',[0.2 0.7 0.9])
    ylim([-3 3])
    xlim([20 80])
    xlabel('Trait Anxiety');
    title(halfstr{h})
    if h == 1
        ylabel('Negative - Positive Surprise')
    end
    coeffs = polyfit(anx_scores.TraitAnx, sh_min_nosh(:,h), 1);
    % Get fitted values
    X = linspace(20, 80);
    Y = polyval(coeffs, X);
    hold on 
    
    plot(X,Y,'Color', [0 0 0], 'HandleVisibility','off')
    [r,p] = corr(sh_min_nosh(:,h), anx_scores.TraitAnx, 'type', 'Pearson');
    if p<0.05
    text(50, -2, ['$r=' num2str(round(r,3)) ', p<.05$' ]);
    else
        text(50, -2, ['$r=' num2str(round(r,3)) ', n.s.$' ]);
    end
end
f.Position(3) = 700;
f.Position(4) = 350;