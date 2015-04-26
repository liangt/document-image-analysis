function [ b_img, thresh ] = th_cluster_zou( img, alpha, n )
%TH_CLUSTER_ZOU  Global image threshold using Zuo's method.
%
% Input:
%   img: gray image
%   alpha: a weight that balances contributions of variance sum and variance
%   discrepancy; when alpha equals 1, this method equals Zou's method.
%   Default is 0.5. In general, alpha ranges between 0.4 and 0.6.
%     n: number of bins (defaults to 256)
% Output:
%   b_img: binarized image
%   thresh: threshold
%
% Reference:
%  Zuoyong Li, Chuancai Liu, Guanghai Liu, Yong Cheng, Xibei Yang, Cairong Zhao. 
%  A novel statistical image thresholding method. 
%  Int. J. Electron. Commun. (AEU) 64 (2010) 1137¨C1147
%
%  Written by Liang Tan (liangtan@zju.edu.cn), 2013/11/28
% 

    if nargin < 3 
        n = 256;
    end
    if nargin < 2 
        alpha = 0.5;
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
    n = 255;
    sigma_squared = inf;
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
        tp1 = sigma_s(i) / p1 - mu_1^2;
        tp2 = (sigma_s(end) - sigma_s(i)) / p2 - mu_2^2;
        sigma_st = alpha*(tp1+tp2) + (1-alpha)*sqrt(tp1*tp2);
        if sigma_st < sigma_squared
            sigma_squared = sigma_st;
            thresh = gray(i);
        end
    end
    
    b_img = img >= thresh;
    
end

