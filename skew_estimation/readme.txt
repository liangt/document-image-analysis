Categories of skew estimation techniques:
  (1) Projection Profile
      A series of projection pro?les are obtained at a number of angles close 
      to the expected orientation and the variation is calculated for each
      of the pro?les. The pro?le which gives maximum variation corresponds to
      the projection with the best alignment to the text lines and that projection
      angle is the actual skew angle of the document.
  (2) Hough Transform
      The peak in the Hough space represents the dominant line and it is skew.
      Drawbacks:
        1) it is computationally expensive 
        2) it is dif?cult to choose a peak in the Hough space when text becomes sparse
  (3) Fourier Transform
      The direction for which the density of the Fourier space is the largest, gives the skew angle.
      Drawbacks:
        It is computationally expensive for large images.
  (4) Nearest-Neighbors Clustering
      Nearest neighbours of all connected components are found, the direction vector 
      for all nearest neighbour pairs are accumulated in a histogram and the histogram 
      peak is found to obtain a skew angle.
  (5) Iinterline Cross Correlation
  (6) power spectral density
  (7) linear regression analysis
  Projection profile methods is fast; the hough transform approach is 
  typically slower than the non-iterative projection profile method, 
  however the accuacy is typically high; Both projection profile method 
  and hough transform method can't handle large amount of skew, while 
  nearest-neighbors method doesn't have this limitation, and of course, 
  its' computation cost is high. 