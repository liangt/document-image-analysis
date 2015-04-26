function b_img = th_local_bernsen( img, l, s )
%TH_LOCAL_BERNSEN  Adaptive Thresholding Using Bernsen's method
%
% Input:
%   img: gray image
%     l: contrast measure, defaults to 15
%     s: size of window, defaults to 31
% Output:
%   b_img: binarized image
%
% Reference:
%   J. Bernsen, "Dynamic thresholding of grey-level images", Proc. Eighth 
%   Int'l Conf. Pattern Recognition, pp. 1,251-1,255, Paris, 1986.
%
%  Written by Liang Tan (liangtan@zju.edu.cn), 2013/11/28
% 

    if nargin < 3
        s = 15;
    end
    if nargin < 2
        l = 15;
    end
    
    [h w] = size(img);
    b_img = false(h,w);
    t = floor((s-1)/2);
    
    for i=1:h
        for j=1:w
            x1 = max(1,i-t);
            x2 = min(h,i+t);
            y1 = max(1,j-t);
            y2 = min(w,j+t);
            l_reg = img(x1:x2,y1:y2);
            zmin = min(l_reg(:));
            zmax = max(l_reg(:));
            zavg = (zmin + zmax)/2;
            if zmax - zmin < l
                if zavg >= 128
                    b_img(i,j) = ~b_img(i,j);
                end
            else
                b_img(i,j) = img(i,j) >= zavg;
            end
        end
    end
    
end

