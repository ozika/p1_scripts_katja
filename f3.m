load('f3.mat')
for i = 1:numel(subs)
    if isempty(find_str_in_cell_exact(exclude_nonlearners, subs{i}))
        valid(c,1) = i;
        c=c+1;
    end
end
phase = {'acq', 'ext'};
data = [];
errors =[];
d=1;
DATA =[];
labels ={};
s={};
s2={};
load_colors;

colors = [faint_red; faint_blue];
col2 = [intense_red; intense_blue];
pl = plot([0.5 0.5], [-0.5 1.5], 'LineStyle', '--','HandleVisibility','off');
pl.Color = [0 0 0];
hold on
for ph = 1:numel(phase)
    trls = find_str_in_cell(ChP.Properties.VariableNames, phase{ph});
    
    
    da = table2array(ChP(valid,trls));
    f = mean(da, 2, 'omitnan');
    DATA(:,d) = f;
    
    ycoord(1:numel(DATA(:,d))) = d-1;
    A = [DATA(:,d), ycoord'];
    [r,c] = find(isnan(A));
    A(r,:) =[];
    m(1:size(A,1)) =80;
    for g = 1:size(A,1)
        coll(g, 1:3)=colors(ph,:);
    end
    s{ph}=scatter(A(:,1), A(:,2), m, coll, 'HandleVisibility','off');
    s{ph}.Marker = '+';
    s{ph}.LineWidth =2.5;
    s2{ph}=scatter(mean(A(:,1)), d-1, 100, col2(ph,:));
    s2{ph}.Marker = '+';
    s2{ph}.LineWidth =2.5;
    d=d+1;
end
l=legend('Acquisiton', 'Extinction');
l.FontSize=13;
xlim([-1 5])
ylim([-0.5 1.5]);
[H,P,CI,STATS] = ttest(DATA(:,1), DATA(:,2));
%title(['T-test: p = ' num2str(round(P,4))])
xlabel('Trials')
q=gca;
q.FontSize = 13;
q.YTick=[];
q.XTick = [-2:0 0.5 1:5];
q.XTickLabel ={'-3','-2', '-1', 'Reversal', '1', '2', '3', '4', '5'};
q.XTickLabelRotation =30;
