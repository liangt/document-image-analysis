function [ b_img, thresh ] = th_attribute_huang( img, n )
%TH_ATTRIBUTE_HUANG Global image threshold using Huang's fuzzy thresholding method
%
% Input:
%   img: gray image
%     n: number of bins (defaults to 256)
% Output:
%   b_img: binarized image
%   thresh: threshold
%
% Reference:
%   L. K. Huang and M. J. J. Wang, 'Image thresholding by minimizing
%   the measures of fuzziness,' Pattern Recogn. 28, 41¨C51 (1995).
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
    hm = -inf;
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
        mu_2 = (mu_t-mu_1)/p2;
        ht = 0;
        for j=1:i
            if p(j)==0
                continue
            end
            tp = n / (n + abs(j-mu_1));
            ht = ht + p(j) * (tp*log(tp) + (1-tp)*log(1-tp)); 
        end
        for j=i+1:n
            if p(j)==0
                continue
            end
            tp = n / (n + abs(j-mu_2));
            ht = ht + p(j) * (tp*log(tp) + (1-tp)*log(1-tp)); 
        end
        if hm < ht
            hm = ht;
            thresh = gray(i);
        end
    end
    
    b_img = img > thresh;

end

