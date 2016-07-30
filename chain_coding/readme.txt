1. Thinning + Chain Coding
   Thining/Skeletonizing/Core-line detection
   Goal: To reduce the image components to their essential information.
   Requirements:
    (1) connected image regions must thin to connected line structures
    (2) the thinned result sholud be minimally eight-connected
    (3) approximate endline locations should be maintained
    (4) the thinning results sholud approximate the medial lines
    (5) extraneous spurs(short branches) caused by thinning should be minimized

   Chain Coding: 
    (1) Freeman Chain Code(FCC)
        It's highly effective for compression of line images, it's designed for
        contours, without any provision for maintaining branching line structures.
        This is fine for compression, but for image analysis, it's importtant to
        retain the complete line structure with all its branches and to know the
        topology at each junction.
    (2) Primitives Chain Code(PCC)
        PCC contains codes for the following features: 
            1) ends of lines
            2) bifurcation and cross junctions
            3) breaks indicating the beginning of coding within a closed contour
        So, it can preserve topological features. It has been applied to analysis
        of fingerprints, maps and engineering diagrams, all of which contain branches
        as important features.

2. Vectorization  
    To represent image lines by the straight line segments that can be drawn within
    the original thicker lines.
   Compared to Thinning+Chain Coding, the advantage is:
      since long lines are searched and found, there are fewer spurs than usually result
    by thinning and chain coding.
   Vectorization is often performed at the initial digitizing level by hardware that 
   locates and tracks long straight line segments.

   Thinning and Chain Coding: 
      attempt to exactly represent the line paths
   Polygonalization:
      attempt to approximate line features
   Vectorization:
      yield something between thinning + chain coding and polygonalization. 
   
