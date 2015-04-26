function [ b_img, thresh] = th_entropy_yen( img, n )
%TH_ENTROPY_YEN  Global image threshold using entropy method.
%
% Input:
%   img: gray image
%     n: number of bins (defaults to 256)
% Output:
%   b_img: binarized image
%   thresh: threshold
%
% Reference:
%  J. C. Yen, F. J. Chang, and S. Chang, 'A new criterion for automatic
%  multilevel thresholding,' IEEE Trans. Image Process. IP-4, 370¨C378
%  (1995).
%
%  Written by Liang Tan (liangtan@zju.edu.cn), 2013/11/28
% 

    if nargin == 1
        n = 256;
    end

    gray_hist = imhist(img,n);
    p = gray_hist / sum(gray_hist);
    omega = cumsum(p);
    hc = cumsum(p.^2);
    
    % Search for gray threshold .
   thresh = 1;
   n = n - 1;
   hm = inf;
   for i=1:n
       if p(i) == 0
           continue
       end
       p1 = omega(i);
       p2 = 1 - p1;
       if p1 == 0 || p2 == 0
           continue
       end
       ht = log(hc(i)/p1^2) + log((hc(end)-hc(i))/p2^2);
       if ht < hm
           hm = ht;
           thresh = i;
       end
   end
   
   thresh = thresh - 1;
   b_img = img >= thresh;

end



