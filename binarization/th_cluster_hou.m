function [ b_img, thresh ] = th_cluster_hou( img, n )
%TH_CLUSTER_HOU Global image threshold using Hou's method.
%
% Input:
%   img: gray image
%     n: number of bins (defaults to 256)
% Output:
%   b_img: binarized image
%   thresh: threshold
%
% Reference:
%  Hou Z, Hu Q, Nowinski WL. On minimum variance thresholding. Pattern
%  Recognition Lett 2006;27:1732¨C43.
%
%  Written by Liang Tan (liangtan@zju.edu.cn), 2013/11/28
% 

    if nargin == 1
        n = 256;
    end

    gray_hist = imhist(img,n);
    n = n - 1;
    p = gray_hist / sum(gray_hist);
    omega = cumsum(p);
    gray = (0:n)';
    mu_s = cumsum(gray .* p);
    sigma_s = cumsum(gray.^2 .* p);
    
    % Search for gray threshold
    thresh = 0;
    sigma_m = inf;
    for i=1:n
        if p(i) == 0
           continue
       end
       p1 = omega(i);
       p2 = 1 - p1;
       if p1 == 0 || p2 == 0
           continue
       end
       mu_1 = mu_s(i) / p1;
       mu_2 = (mu_s(end) - mu_s(i)) / p2;
       sigma_1 = sigma_s(i) / p1 - mu_1^2;
       sigma_2 = (sigma_s(end) - sigma_s(i)) / p2 - mu_2^2;
       sigma_st = sigma_1 + sigma_2;
       if sigma_m > sigma_st
           sigma_m = sigma_st;
           thresh = gray(i);
       end
    end

    b_img = img > thresh;

end

