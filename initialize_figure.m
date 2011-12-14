function h = initialize_figure(options)
if isempty(options.PopulationEvolutionAxe)
    % If axes are empty, then the GUI is not used, must set up figure
    h=figure;
    subplot(3, 2 , [1 2]);
    colormap('gray');
    title(['Selected variables'],'FontSize',16);
    ylabel('Variables','FontSize',16);
    options.PopulationEvolutionAxe = gca;
    
    subplot(3, 2 , [3 4] );
    xlabel('Generations','FontSize',16);
    ylabel('Mean cost','FontSize',16);
    options.FitFunctionEvolutionAxe = gca;
    
    
    subplot(3, 2 , 5); % ROC
    xlabel('Sensitivity'); ylabel('1-Specificity');
    options.CurrentScoreAxe = gca;
    
    subplot(3, 2 , 6);
    xlabel('Variables','FontSize',16);
    ylabel('Genomes','FontSize',16);
    title('Current Population','FontSize',16);
    options.CurrentPopulationAxe = gca;
else
    h=gcf;
end
    
end