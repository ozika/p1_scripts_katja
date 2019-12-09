function[] = plot_significance(xcoord, ycoord, nos, yof)
noplots = size(xcoord,1);
of=0.075;
%yof = 0.035;

for i = 1:noplots
    plot(xcoord(i,:), zeros(1,2)+ycoord(i),  'Color', 'k', 'HandleVisibility','off')
    stof = (nos(i)-1)*of/2;
    if nos(i) == 0
         text(mean(xcoord(i,:))-0.13,  ycoord(i)+yof, 'n.s.');  
    else
        for n = 1:nos(i)
            scatter(mean(xcoord(i,:))-stof+(n-1)*of,ycoord(i)+yof, 20, '*', 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k', 'HandleVisibility', 'Off')

        end
    end
    
end

