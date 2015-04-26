1. Layout Analysis:
   (1) Structural layout analysis/ Physical and geometric layout analysis
        To obtain a physical segmentation of groups of document components.
   (2) Functinal layout analysis/ Syntactic and logical layout analysis
        Use domain-dependent information consisting of layout rules of a 
        particular page to perform labeling of the structural blocks giving 
        some indication of the function of the block.
2. Structure Layout Analysis:
   (1) Top-Down Analysis
       A page is segmented from large components to smaller sub-components.
       A primary advantage is: 
             it uses global page structure to its benefit to perform layout 
         analysis quickly.
       However, for pages where text does not have linear bounds, and where 
       figures are intermixed in and around text, it may be inappropriate.
   (2) Bottom-Up Analysis 
       It is more appropriate for non-Manhattan layouts, while it's usually
       more expensive to compute.
       Connected components are merged into characters, then words, then 
       text lines, etc.
3. Top-Down Analysis
   Smooth -- To smooth characters into smaller, unrecognizable blobs.
     RLSA: Run-length Smoothing Algorithm
   XY-Cut:  using foreground text for layout analysis
   Baird 1990: using background white space for layout analysis
   The advantages of using background white space versus the foreground text 
   for layout analysis are:
      (1) language-independence
      (2) few parameters need be specified
   Disadvantage:
      the choice of what constitutes a maximal rectangle may be non-intuitive 
   and different for differently formatted documents