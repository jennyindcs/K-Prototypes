% Compute centroids - return a matrix of data points as centroids for X
% Apply mode of categorial data points as values for categorical attributes of
% centroids

function centroids = computeCentroids(Xnum, Xcat, idx, K)

[m n] = size([Xcat Xnum]);

centroids = zeros(K, n);

for i=1:K,
  indx = (idx(:,1)== i);
  try
     centroids(i,:) = [findMode(Xcat, indx) computeMean(Xnum, indx)];
  catch
     msg = lasterror.message;
     fprintf(strcat(msg, '\n'));
  end_try_catch
end;

end


% return a row vector to represent the means per numerical attribute
function Vmean = computeMean(M, indx)

Vmean = sum(M(indx,:),1)./size(M(indx,:),1);

end


% return a row vector to represent the modes per categorical
% attribute
function Vmode = findMode(M, indx)

Vmode = mode(M(indx,:));

end
