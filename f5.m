load('f5.mat');
for g = 1:post_req/increm
    start_t =(g-1)*increm+1;
    end_t = (g-1)*increm+increm;
    if start_t == end_t
        labels{g+1} = ['tr' num2str(end_t)];
    else
        labels{g+1} = [num2str(start_t) '-' num2str(end_t)];
    end
    
end
 f=figure;
for h =1:2
    DATA = ER_DATA.byHalf{h}.MEAN;
    for ph = 1:2
        id = find_str_in_cell(DATA.Properties.VariableNames, phase_str{ph});
        tempd = table2array(DATA(:,id(1:n)));
        groupped=[];
        for g = 1:n/increm
            groupped(:,g) = mean(tempd(:,((g-1)*increm+1):((g-1)*increm+increm)),2, 'omitnan');
        end
        d(1:subs,1:n/increm,ph)=groupped;
        
    end
    do=1;
    if do == 1
        try
        [tbl, r] = simple_mixed_anova(d, [], {'Trial', 'Phase'}, {});
        disp(['Half ' num2str(h)])
        disp(tbl)
        end
            
    end

    %set(gca, 'XTick', 1:numel(labels));
    %set(gca, 'XTickLabels', labels);
    %%%%% PLOT
    subplot(1,2,h)
    acq = squeeze(d(:, :, 1));
    ext = squeeze(d(:, :, 2));
    
    data(1,1:n/increm) = mean(acq, 'omitnan');
    data(2,1:n/increm) = mean(ext, 'omitnan');
    errors(1,1:n/increm) = stderror(acq);
    errors(2,1:n/increm) = stderror(ext);
    
    pos=[];
    for i = 1:2
        pos(i,:) = 1:n/increm;
    end
    e= errorbar(pos', data', zeros(n/increm,2),errors', 'Marker', 'diamond');
    [e(1).Color] = deal([0 0 0]);
    [e(2).Color] = deal([0.6 0.6 0.6]);
    [ e(2).LineWidth, e(1).LineWidth] = deal(1);
    ylim([-0.05 1.05])
    
        l=legend('Acquisition', 'Extinction');
    t = gca;
    t.XTick = [pre_req+0.5 pre_req+1:n];
    t.XTickLabel = labels;
    t.XTickLabelRotation=20;
    xcoord = zeros(1,2) + pre_req+0.5;
    ycoord = [-0.1 1.1];
    hold on 
    plot(xcoord, ycoord, 'Color',[0.7 0.7 0.7], 'LineStyle','--', 'HandleVisibility','off');
    
    %tt.FontSize = 13;
    xlim([0.8 n/increm+0.2]);
    ylabel('Mean Probability')
    title(['Half ' num2str(h)])
end
f.Position(3) = 700;