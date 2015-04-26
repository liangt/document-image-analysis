Thining/Skeletonizing/Core-line detection
  Goal: To reduce the image components to their essential information.
  Requirements:
   (1) connected image regions must thin to connected line structures
   (2) the thinned result sholud be minimally eight-connected
   (3) approximate endline locations should be maintained
   (4) the thinning results sholud approximate the medial lines
   (5) extraneous spurs(short branches) caused by thinning should be minimized
  Matlab Function: 
    bwmorph函数用于基于膨胀，腐蚀和查找表操作的组合实现多种操作，
    其调用语法:  g = bwmorph(f, operation, n) 
      当operation为skew/thin时，执行Skeltonizing/Thining
      在Skeltonizing/Thining过程中可能会出现一些spurs(毛刺),可
      设置operation为spur来去掉这些毛刺点     