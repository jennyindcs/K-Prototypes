# K-Prototypes
Octave implementation of the K-Prototypes clustering algorithm

## Description

The K-Prototypes algorithm is an extension to the K-Means algorithm for clustering objects described by mixed numeric and categorical attributes [1]. It integrates the K-Means and K-Modes processes to cluster data with mixed attributes. 

To be more concrete, K-Prototypes applies the squared Euclidean distance measure on numeric attributes and the simple matching dissimilarity measure [2] on categorical attributes for finding the closest centroids of objects.

This is an implementation of K-Prototypes using the Octave language.

## Usage

```octave
[centroids, idx] = kprototypes(file, p, n, K, max_init, max_iters);
```

Parameters:

file - the input data file that consists of m instances of which have n total attributes (m x n matrix)

p - the number of numeric attributes

n - the total number of attributes

max_init - max runs that the algorithm will initialise centroids randomly

max_iters - max iterations that the algorithm will try to reach converge

Outputs:

The function saves all the results including centroids, cluster indices for all the instances, the costs for all the runs, and the number of the run that give the minimum cost. 

It also plots the cost function as a function of the number of runs, and saves it to a file.

## References

[1] Z. Huang, “Extensions to the k-means algorithm for clustering large data sets with categorical values,” Data mining and knowledge discovery, vol. 2, no. 3, pp. 283–304, 1998.

[2] L. Kaufman and P. J. Rousseeuw, Finding groups in data: an introduc- tion to cluster analysis. John Wiley & Sons, 2009, vol. 344.
