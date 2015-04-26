function b_img = th_local_bradley( img, s, t )
%TH_LOCAL_BRADLEY Adaptive Thresholding Using the Integral Image
%
% Input:
%   img: gray image
%     s: size of window, default value is 1/8 of the image width
%     t: percent of the average of nearby pixels to set to black, default
%     value is 15
% Output:
%   b_img: binarized image
%
% Reference:
%  Bradley, G., Roth, G, "Adaptive Thresholding Using the Integral Image,"
%  Journal of Graphics Tools, Vol. 12, No. 2 p. 13-21, 2007 NRC 50002
%
%  Written by Liang Tan (liangtan@zju.edu.cn), 2013/11/28
% 

    [h w] = size(img);
    if nargin == 2
        t = 15;
    elseif nargin == 1
        s = floor(w/8);
        t = 15;
    end
    intImg = integralImage(img);
    b_img = false(h,w);
    p = (100-t)/100;
    
    for i=1:h
        for j=1:w
            x1 = max(1,floor(i-s/2));
            x2 = min(h,floor(i+s/2));
            y1 = max(1,floor(j-s/2));
            y2 = min(w,floor(j+s/2));
            sm = intImg(x2,y2)-intImg(x2,y1)-intImg(x1,y2)+intImg(x1,y1);
            count = (x2-x1+1)*(y2-y1+1);
            b_img(i,j) = img(i,j) > sm*p/count;
        end
    end  
    
end

