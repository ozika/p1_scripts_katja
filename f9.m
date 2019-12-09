load('f9.mat');
f=figure;
labels= {'First Half: Acquisition', 'Second Half: Acquisition', 'First Half: Extinction', 'Second Half: Extinction'}
for i = 1:size(DATA,2)
    subplot(2,2,i)
    s=scatter(DATA.(i), anx_scores.TraitAnx, 20, [0 0 0], 'MarkerFaceColor', [0.8 0.6 0.1]);
    [r,p] = corr(DATA.(i), anx_scores.TraitAnx, 'type', 'Pearson');
        t=text(0.1, 75, [' r=' num2str(round(r,2)) ' p=' num2str(round(p,3))]);
        xlim([0 1]);
        ylim([20 80])
        title(labels{i})
        hold on 
        coeffs = polyfit(DATA.(i), anx_scores.TraitAnx, 1);
        % Get fitted values
        X = linspace(0, 1);
        Y = polyval(coeffs, X);
        plot(X, Y, 'LineWidth', 0.8, 'Color', [0 0 0]);
        ylabel('Trait Anxiety');
end
f.Position(3) = 700;
f.Position(4) = 700;