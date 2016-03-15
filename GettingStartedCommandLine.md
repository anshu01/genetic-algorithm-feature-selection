# Introduction #

This page will provide a basic functionality framework for using the GAFS toolbox in MATLAB. This framework is provided in the form of a demo script which can be run from the GAFS toolbox path. Replace inputs `X` and target `y` with your data as desired.

# Demo code #
```
%=== This demo shows the user how to perform feature selection with the GA toolbox using all default parameters.
close all;
%== First, create synthetic data
X=rand(1000,10);

%=== Create output that is dependent on synthetic data
y=X(:,3) | (X(:,5) & X(:,7));

%=== Open parallel processing pool if using (set parallelizeFlag=0 if not)
parallelizeFlag = 0;
if (exist('matlabpool','file')==2) && parallelizeFlag
    if matlabpool('size')<=0
        matlabpool;
    end
else
    parallelizeFlag = 0;
end

%=== Next, instantiate the GA options
% A full list of options is available in the help file
opts=ga_opt_set('Parallelize',parallelizeFlag,'OptDir',1,...
    'CostFcn',@cost_AUROC,'FitnessFcn',@fit_BinomialGLM,...
    'ErrorIterations',10,'ErrorGradient',0.005,...
    'MinimizeFeatures',false,'PlotFcn','plot_All',...
    'PopulationSize', 24,...
    'ConfoundingFactors', [], ...
    'CrossValidationFcn',@xval_Kfold, 'CrossValidationParam', 5,...
    'Repetitions', 1,'MaxIterations',50,'Display','Plot');

% Run the GA
fprintf('Training GA...\n');
[ga_out, ga_options] =  AlgoGen(X,y,opts);

%=== Save the output
save('gaExample.mat','ga_out','ga_options');

%=== Close the parallel toolbox
if (exist('matlabpool','file')==2) && matlabpool('size')>0
    matlabpool close;
end
```