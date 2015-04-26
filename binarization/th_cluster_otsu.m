function [ b_img, thresh ] = th_cluster_otsu( img, n )
%TH_CLUSTER_OTSU Global image threshold using Otsu's method.
%
% Input:
%   img: gray image
%     n: number of bins (defaults to 256)
% Output:
%   b_img: binarized image
%   thresh: threshold
%
% Reference:
%  N. Otsu, "A Threshold Selection Method from Gray-Level Histograms,"
%  IEEE Transactions on Systems, Man, and Cybernetics, vol. 9, no. 1,
%  pp. 62-66, 1979.
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
    mu_s = cumsum(gray.*p);
    mu_t = mu_s(end);
    
    % Search for gray threshold that minimize the within-class variance
   thresh = 0;
   sigma_b_squared = 0;
   for i=1:n
       if p(i) == 0
           continue
       end
       p1 = omega(i);
       p2 = 1 - p1;
       if p1 == 0 || p2 == 0
           continue
       end
       mu_1 = mu_s(i)/p1;
       mu_2 = (mu_t-mu_s(i))/p2;
       tp1 = p1*(mu_1-mu_t)^2;
       tp2 = p2*(mu_2-mu_t)^2;
       sigma_b_s = tp1 + tp2;
       if sigma_b_s > sigma_b_squared
           sigma_b_squared = sigma_b_s;
           thresh = gray(i);
       end
   end
   
   b_img = img > thresh;

end

