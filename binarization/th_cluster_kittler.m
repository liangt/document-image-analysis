function [ b_img, thresh ] = th_cluster_kittler( img, n )
%TH_CLUSTER_KITTLER Global image threshold using minimum error thresholding method.
%
% Input:
%   img: gray image
%     n: number of bins (defaults to 256)
% Output:
%   b_img: binarized image
%   thresh: threshold
%
% Reference:
%  J. Kittler, J. Illingworth, Minimum error thresholding
%  Pattern Recognition, 19 (1986), pp. 41¨C47
%  Q. Ye, P. Danielsson, On minimum error thresholding and its implementations
%  Pattern Recognition Lett., 7 (1988), pp. 201¨C206
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
    
    % Search for gray threshold that minimize error
    thresh = 0;
    etpy_m = inf;
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
        if sigma_1 <= 1e-4 || sigma_2 <= 1e-4
            continue
        end
        etpy = p1*log(sqrt(sigma_1)/p1) + p2*log(sqrt(sigma_2)/p2);
        if etpy_m > etpy
            etpy_m = etpy;
            thresh = gray(i);
        end
    end
    
    b_img = img > thresh;
    
end

