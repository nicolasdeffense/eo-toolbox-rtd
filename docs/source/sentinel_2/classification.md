The classification step consists in one or many numerical processes to finally allocate every pixel or object to one of the classes of the land cover typology. The vast diversity of classification algorithms can be split into two main types:
- the supervised type, which uses a training data set to calibrate the algorithm a priori;
- and the unsupervised type, which produces clusters of pixels to be labelled a posteriori as land cover class in light of in situ or ancillary information.


## Classification based on Random Forests

Random Forest (RF), an improved implementation of Decision Trees (DT), is an ensemble-learning algorithm that combines multiple classifications of the same data to produce higher classification accuracies than other forms of DT. RF works by fitting many DT-based classifications to a data set, and then uses a rule-based approach to combine the predictions from all the trees. During this process, individual trees are grown from differing subsets of training data using a process called “bagging”. Bagging involves the random subsampling (with replacement) of the original data for growing each tree. Generally, for each tree grown, two thirds of the training data are used to grow the tree, while the remaining one third are left unused (out-of-bag, or OOB) for later error assessment. A classification is then fit to each bootstrap sample; however, at each node (split), only a small number of randomly selected predictor variables are used in the binary partitioning. The splitting process continues until further subdivision no longer reduces the Gini index. Each tree contributes to the assignment of the most frequent class to the input data with a single vote. The predicted class of an observation is calculated by the majority vote for that observation, with ties split randomly. [^1] [^2] [^3]

> **The random forest combines hundreds or thousands of decision trees, trains each one on a slightly different set of the observations, splitting nodes in each tree considering a limited number of the features. The final predictions of the random forest are made by averaging the predictions of each individual tree.**

[Watch this video if Decision Trees are not clear for you !](https://www.youtube.com/watch?v=7VeUPuFGJHk)

[Watch this video if Random Forest are not clear for you !](https://www.youtube.com/watch?v=J4Wdy0Wc_xQ)


In this chapter we will see how to use the Random Forest implementation provided by the `scikit-learn` library. Scikit-learn is an amazing machine learning library that provides easy and consistent interfaces to many of the most popular machine learning algorithms. It is built on top of the pre-existing scientific Python libraries, including NumPy, SciPy, and matplotlib, which makes it very easy to incorporate into your workflow. The number of available methods for accomplishing any task contained within the library is its real strength.



![Image classification](figures/im_classif_pixel.png)

![Image classification](figures/classif_namur_2020.png)
Namur, 2020 (NDVI & monthly composites S1 backscattering VV)




[^1] : [Handbook on remote sensing for agricultural statistics](https://nicolasdeffense.github.io/eo-toolbox/docs/Remote_Sensing_for_Agricultural_Statistics.pdf)

[^2] : [Chris Holden's tutorial](https://ceholden.github.io/open-geo-tutorial/python/chapter_5_classification.html)

[^3] : [An Implementation and Explanation of the Random Forest in Python](https://towardsdatascience.com/an-implementation-and-explanation-of-the-random-forest-in-python-77bf308a9b76)