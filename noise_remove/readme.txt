1. 形态学方法
     腐蚀: imerode   去除边界点，孤立点
     膨胀: imdilate    填补空洞
     开运算: imopen   先腐蚀，后膨胀
        smooth boundaries, narrow isthmuses broken, and eliminate small noise regions
     闭运算: imclose  先膨胀，后腐蚀 
        smooth boundaries, narrow gaps joined, and fill small noise holes
    Morphology methods perform  quite  well  in  general  for removing noise in binary 
    images. In case of document images,  however, they  may  significantly  damage  the 
    sharpness of the text and graphics components.

2. kFill filter 
    It's designed specifically for document images to reduce salt-and-pepper noise while 
    maintaining readability.
    kfill: The original kFill filter
    kfill_m: a single iteration filter based on kFill