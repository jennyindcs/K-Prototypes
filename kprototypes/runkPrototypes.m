function [centroids, idx] = runkPrototypes(Xnum, Xcat, initial_centroids, ...
                                     K, max_init, max_iters, plot_progress)

% Set default value for plot progress
if ~exist('plot_progress', 'var') || isempty(plot_progress)
    plot_progress = false;
end

% Plot the data if we are plotting progress
if plot_progress
    figure;
    hold on;
end

% Initialize values
[m n] = size([Xcat Xnum]);
centroids = initial_centroids;
previous_centroids = centroids;
idx = zeros(m, 1);
previous_idx = idx;

% Run K-Prototypes
allCentroids = cell(1,max_init);
allIdx = cell(1,max_init);
allCosts = cell(1,max_init);
allNinit = cell(1,max_init);

% Get a colormap
cmap = hsv(max_init);

for i=1:max_init
fprintf('K-Prototypes Run %d/%d...\n', i, max_init);
fprintf('Random initialization...\n');

centroids = randomInitCentroids([Xcat Xnum], K);

converged = false;
costPerIter = Inf;
costPerInit = [];
j = 1;
while (j <= max_iters && !converged)
    moves = 0;
    
    % Output progress
    fprintf('K-Prototypes iteration %d/%d...\n', j, max_iters);
    
    % For each instance in X, assign it to the closest centroid
    [idx, totalCost] = findClosestCentroids(Xnum, Xcat, centroids, ' ');
    moves = sum(idx ~= previous_idx, 1);
    
    converged = (moves == 0) || (totalCost >= costPerIter);
    costPerIter = totalCost;
    costPerInit = [costPerInit costPerIter];
    
    % Given the memberships, compute new centroids
    centroids = computeCentroids(Xnum, Xcat, idx, K);
    j++;
endwhile

if plot_progress
    plotCostFunc(costPerInit, 'color', cmap(i,:));
end

allCentroids{i} = centroids;
allIdx{i} = idx;
allCosts{i} = min(costPerInit);
allNinit{i} = i;

endfor

legendNames = ['Iteration 1'];
for l=2:max_init
    legendNames = [legendNames; cstrcat('Iteration ', int2str(l))];    
endfor

if plot_progress
    grid on;
    legend(legendNames);
    print('costfunc.png', '-dpng');
    fprintf('Saving cost function plotting to file\n');
    pause;
end

M = cell2mat(allCosts)
[minimumCost, bestRun] = min(M)
centroids = allCentroids{bestRun};
idx = allIdx{bestRun};

csvwrite('costs.csv', M);
csvwrite('min.csv', [minimumCost, bestRun]);

end


