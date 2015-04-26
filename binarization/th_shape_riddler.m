function [b_img thresh] = th_shape_riddler( img, n )
%TH_SHAPE_RIDDLER Global image threshold using iterative selection method.
%  An iterative algorithm that gives similar results as the Otsu's
%  algorithm. Computationally less intensive than it.
%
% Input:
%   img: gray image
%     n: number of bins (defaults to 256)
% Output:
%   b_img: binarized image
%   thresh: threshold
%
% Reference:
%  T. Ridler and S. Calvard. Picture thresholding using iterative selection
%  method, IEEE Trans. Systems Man Cybernet. SMC-8, 1978, 630-632
%  H.J. Trussell. Comments on "Picture thresholding using iterative selection
%  method", IEEE Trans. Systems Man Cybernet. SMC-9, 1979, 311
%
%  Written by Liang Tan (liangtan@zju.edu.cn), 2013/11/28
% 

    if nargin == 1
        n = 256;
    end
    
    gray_hist = imhist(img,n);
    p = gray_hist / sum(gray_hist);
    omega = cumsum(p);
    n = n -1;
    gray = (0:n)';
    mu_s = cumsum(gray.*p);
    
    mu = floor(mu_s(end));
    thresh = 0;
    while thresh ~= mu
        idx = mu + 1;
        p1 = omega(idx);
        p2 = 1 - p1;
        if p1 == 0 || p2 == 0
            continue
        end   
        mu_1 = mu_s(mu+1)/p1;
        mu_2 = (mu_s(end)-mu_s(mu+1))/p2;
        thresh = mu;
        mu = floor((mu_1+mu_2)/2);
    end
    
    b_img = img > thresh;

end

