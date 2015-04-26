function [ b_img, thresh ] = th_attribute_tsai( img, n )
%TH_ATTRIBUTE_TSAI Global image threshold using moment preservation method.
%
% Input:
%   img: gray image
%     n: number of bins (defaults to 256)
% Output:
%   b_img: binarized image
%   thresh: threshold
%
% Reference:
%  W-H. Tsai, "Moment-preserving thresholding: A new method approach," 
%  Computer Vision, Graphics, and Image Processing, 
%  vol. 29, pp. 377-393, 1985.
%
%  Written by Liang Tan (liangtan@zju.edu.cn), 2013/11/28
% 

    if nargin == 1
        n = 256;
    end

    gray_hist = imhist(img,n);
    p = gray_hist / sum(gray_hist);
    moments = ones(3,1);
    for i=1:3
        moments(i) = (0:255).^i * p;
    end
    
    x1 = (moments(1)*moments(3)-moments(2)^2)/(moments(2)-moments(1)^2);
    x2 = (moments(1)*moments(2)-moments(3))/(moments(2)-moments(1)^2);
    p1 = 0.5 - (moments(1)+x2/2)/sqrt(x2^2-4*x1);
    
    sm = 0;
    for thresh=1:256
        sm = sm + p(thresh);
        if sm >= p1
            break
        end
    end
    thresh = thresh - 1;
    b_img = img > thresh;

end

