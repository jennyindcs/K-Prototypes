function [idx, totalCost] = findClosestCentroids(Xnum, Xcat, centroids, gamma)

% Set K
K = size(centroids, 1);
[m,n] = size([Xnum Xcat]);

% number of numerical attributes
p = size(Xnum, 2);

% number of categorial attributes
l = size(Xcat, 2);

% return a vector containing the index of the closest centroid for every training instance 
idx = zeros(m, 1);
totalCost = 0;

% estimate a good value for gamma if no value is provided (see Huang[1997])
if gamma == ' ',
  gamma = 0.5 * std(reshape(Xnum, 1, m*p));
end;

for i=1:m,
  cost = euclideanDissim(Xnum(i,:), centroids(:,l+1:n)) + gamma * matchingDissim(Xcat(i,:), centroids(:,1:l));
  [d, id]=min(cost);
  idx(i,1)=id;
  totalCost += cost(id);
end;

end


% euclidean dissimilarity between a vector and the centroids matrix
function eucDissim = euclideanDissim(x, centroids)

eucDissim = sum((x - centroids).^2, 2);

end

% simple matching dissimilarity between a vector and the centroids matrix
function matDissim = matchingDissim(x, centroids)

matDissim = sum(x ~= centroids, 2);

end


