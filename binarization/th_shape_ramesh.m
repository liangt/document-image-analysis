function [b_img thresh] = th_shape_ramesh( img, n )
%TH_SHAPE_RAMESH  Global image threshold using Ramesh's method.
%
% Input:
%   img: gray image
%     n: number of bins (defaults to 256)
% Output:
%   b_img: binarized image
%   thresh: threshold
%
% Reference:
%  N. Ramesh, J. H. Yoo, and I. K. Sethi, 'Thresholding based on histogram 
%  approximation,' IEE Proc. Vision Image Signal Process. 142(5), 271�C279 
%  (1995).
%
%  Written by Liang Tan (liangtan@zju.edu.cn), 2013/11/27
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
       sigma_st = i*mu_1*(mu_1-gray(i)) + (n-gray(i))*mu_2*(mu_2-i-n) ;
       if sigma_m > sigma_st
           sigma_m = sigma_st;
           thresh = gray(i);
       end
    end

    b_img = img > thresh;
   
end

