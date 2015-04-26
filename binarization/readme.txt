Categorize the thresholding methods in six groups according to the 
information they are exploiting. These categories are:
   1. histogram shape-based methods, where, for example,the peaks, 
      valleys and curvatures of the smoothed histogram are analyzed
   2. clustering-based methods, where the gray-level samples are 
      clustered in two parts as background and foreground ~object!, 
      or alternately are modeled as a mixture of two Gaussians
   3. entropy-based methods result in algorithms that use the entropy
      of the foreground and background regions, the cross-entropy 
      between the original and binarized image, etc.
   4. object attribute-based methods search a measure of similarity 
      between the gray-level and the binarized images, such as fuzzy 
      shape similarity, edge coincidence, etc.
   5. the spatial methods use higher-order probability distribution 
      and/or correlation between pixels
   6. local methods adapt the threshold value on each pixel to the 
      local image characteristics.

Convetion of function name: th_category_anthor
   category: shape/cluster/entropy/attribute/spatial/local

Functions:
   1. Histogram Shape-Based Thresholding Methods
     (1) Convex hull thresholding
        th_shape_rosenfeld   
        Thresh = argmax{p(g)-Hull(g)} by considering object attributes, 
        such as busyness.
     (2) Peak-and-vally thresholding
        th_shape_prewitt  
        For images with distinct objects and background, the histogram
        of the gray levels will be bimodal. In this case, a threshold
        can be chosen as the gray level that corresponds to the valley
        of the histogram. The technique is called the mode method. 
     (3) Shape-modeling thresholding
        th_shape_ramesh
        Minimize the sum of squares bewteen a bilevel function and histogram.
   2. Clustering-Based Thresholding Methods
     (1) Clustering thresholding
        th_cluster_riddler 
        An iterative algorithm that gives similar results as the Otsu's
        algorithm. Computationally less intensive than it.
        th_cluster_otsu
        Minimize within-class  variance and maximize between-class variance.
        Separability measure = between-class variance / total-variance serves
        as a measurement of class separability between the two classes, or 
        the bimodality of the histogram.
        th_cluster_hou
        Minimize the class variances.
        th_cluster_zou
        Generalization of Hou's method. It takes class variance sum and 
        variance discrepancy into account at the same time and constructs a
        novel statistical criterion for threshold selection
     (2) Minimum error thresholding
        th_cluster_kittler
        Views the histogram as an estimate of the probability density function 
        of a Gaussian mixture model(objects and background)  
   3. Entropy-Based Thresholding Methods
     (1) Entropic thresholding
         th_entropy_kapur
         th_entropy_yen
        Consider the image foreground and background as two different signal 
        sources, so that when the sum of the two class entropies reaches its 
        maximum, the image is said to be optimally thresholded.
         th_entropy_sahoo
        Using Renyi entropy for three different paramenter alpha, that's:
        0<alpha<1, alpha=1, alpha>1; and combine the results of three different 
        threshold values.
     (2) Cross-entropic thresholding
         th_entropy_li
        Minimize the cross entropy of the image and its segmented version.
     (3) Fuzzy entropic thresholding
         th_entropy_shanbhag
   4. Attribute similarity-Based Thresholding Methods
     (1) Moment preserving thresholding
         th_attribute_tsai
        The thresholding is established so that the ?rst three gray-level
        moments match the ?rst three moments of the binary image.
     (2) Fuzzy similarity thresholding
         th_attribute_huang
   5. Locally adaptive thresholding
     In this class of algorithms, a threshold is calculated at each pixel, 
     which depends on some local statistics like range, variance, or 
     surface-?tting parameters of the pixel neighborhood.
     (1) Local variance method
         th_local_niblack
        The method adapts the threshold according to the local mean and 
        standard deviation and calculated a window size of b*b.
         th_local_sauvola
        An improvement on the Niblack method, especially for stained and 
        badly illuminated documents. It adapts the contribution of the 
        standard deviation.
     (2) Local contrast method
          th_local_white
         Compares the gray value of the pixel with the average of the gray 
         values in some neighborhood (15*15 window suggested) about the 
         pixel, chosen approximately to be of character size. If the pixel 
         is signi?cantly darker than the average, it is denoted as character;
         otherwise, it is classi?ed as background.
          th_local_bernsen
         The threshold is set at the midrange value, which is the mean of 
         the minimum and maximum gray values in a local window of suggested
         size w=31.
          th_local_bradley
