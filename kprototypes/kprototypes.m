% K-Prototypes algorithm implementation

function [centroids, idx] = kprototypes(file, p, n, K, max_init, max_iters)

%% Initialization
clear; close all; clc

fprintf('\nRunning K-Prototypes clustering on the training dataset.\n\n');
X = load(file);
Xnum = X(:,1:p);
Xcat = X(:,p+1:n);
initial_centroids = [];

% Run K-Prototypes algorithm. The 'true' at the end tells the function to plot
% the cost function
[centroids, idx] = runkPrototypes(Xnum, Xcat, initial_centroids, K, max_init, max_iters, true);

csvwrite('idx.csv', idx);
csvwrite('centroids.csv', centroids);

fprintf('\nK-Prototypes Done.\n\n');

fprintf('Program paused. Press enter to continue.\n');
pause;

end