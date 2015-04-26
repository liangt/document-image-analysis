function [ b_img, thresh ] = th_entropy_kapur( img, n )
%TH_ENTROPY_KAPUR Global image threshold using entropy method.
%
% Input:
%   img: gray image
%     n: number of bins (defaults to 256)
% Output:
%   b_img: binarized image
%   thresh: threshold
%
% Reference:
%  J.N. Kapur, P.K. Sahoo, A.K.C. Wong, "A new method for Gray-Level picture thresholding 
%  using the entropy of the histogram," Computer Vision, Graphics, and Image Processing, 
%  vol. 29, pp. 273-285, 1985.
%
%  Written by Liang Tan (liangtan@zju.edu.cn), 2013/11/28
% 

    if nargin == 1
        n = 256;
    end

    gray_hist = imhist(img,n);
    p = gray_hist / sum(gray_hist);
    omega = cumsum(p);
    h = zeros(n,1);
    for i=1:256
        if p(i) ~= 0
            h(i) = -p(i) * log(p(i));
        end
    end
    hc = cumsum(h);
    
    % Search for gray threshold that maximize the sum of two entropies.
   thresh = 1;
   n = n - 1;
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
       ht = hc(i)/p1 + (hc(end)-hc(i))/p2 + log(p1*p2);
       if ht > hm
           hm = ht;
           thresh = i;
       end
   end
   
   thresh = thresh - 1;
   b_img = img > thresh;

end

