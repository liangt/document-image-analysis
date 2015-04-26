function [ b_img, thresh ] = th_entropy_li( img, n )
%TH_ENTROPY_LI Global image threshold using cross entropy.
%
% Input:
%   img: gray image
%     n: number of bins (defaults to 256)
% Output:
%   b_img: binarized image
%   thresh: threshold
%
% Reference:
%   Li C.H. and Lee C.K. (1993) "Minimum Cross Entropy Thresholding" 
%   Pattern Recognition, 26(4): 617-625
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
    
    % Search for gray threshold
   thresh = 0;
   hm = 0;
   for i=1:n
       if p(i) == 0
           continue
       end
       p1 = omega(i);
       p2 = 1 - p1;
       if p1 == 0 || p2 == 0
           continue
       end
       mu1 = mu_s(i);
       mu2 = mu_t-mu_s(i);
       mu_1 = mu1/p1;
       mu_2 = mu2/p2;
       ht = mu1*log(mu_1) + mu2*log(mu_2);
       if hm < ht
           hm = ht;
           thresh = gray(i);
       end
   end
   
   b_img = img > thresh;

end

