function [ b_img, thresh ] = th_entropy_sahoo( img, n )
%TH_ENTROPY_SAHOO Global image threshold using Renyi's entropy.
%
% Input:
%   img: gray image
%     n: number of bins (defaults to 256)
% Output:
%   b_img: binarized image
%   thresh: threshold
%
% Reference:
%   Sahoo P.K., Wilkins C., and Yeager J. (1997) "Threshold Selection
%   Using Renyi's Entropy" Pattern Recognition, 30(1): 71-84
%
%  Written by Liang Tan (liangtan@zju.edu.cn), 2013/11/28
% 

    if nargin == 1
        n = 256;
    end

    gray_hist = imhist(img,n);
    p = gray_hist / sum(gray_hist);
    omega = cumsum(p);
    
    % Search for gray threshold  when alpha = 1.
    h = zeros(n,1);
    for i=1:256
        if p(i) ~= 0
            h(i) = -p(i) * log(p(i));
        end
    end
    hc = cumsum(h);
    
   thresh2 = 1;
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
           thresh2 = i;
       end
   end 
   
   % Search for gray threshold  when alpha=2.
   hc = cumsum(p.^2);
   thresh3 = 1;
   hm = inf;
   for i=1:n
       p1 = omega(i);
       p2 = 1 - p1;
       if p1 == 0 || p2 == 0
           continue
       end
       ht = log(hc(i)/p1^2) + log((hc(end)-hc(i))/p2^2);
       if ht < hm
           hm = ht;
           thresh3 = i;
       end
   end  
   
   % Search for gray threshold  when alpha=0.5.
   hc = cumsum(sqrt(p));
   thresh1 = 1;
   hm = 0;
   for i=1:n
       p1 = omega(i);
       p2 = 1 - p1;
       if p1 == 0 || p2 == 0
           continue
       end
       ht = log(hc(i)/sqrt(p1)) + log((hc(end)-hc(i))/sqrt(p2));
       if ht > hm
           hm = ht;
           thresh1 = i;
       end
   end  
   
   if (abs(thresh1-thresh2)<=5 && abs(thresh2-thresh3)<=5) || (abs(thresh1-thresh2)>5 && abs(thresh2-thresh3)>5)
       b1 = 1; b2 = 2; b3 = 1;
   end
   if (abs(thresh1-thresh2)<=5 && abs(thresh2-thresh3)>5)
       b1 = 0; b2 = 1; b3 = 3;
   end
   if (abs(thresh1-thresh2)>5 && abs(thresh2-thresh3)<=5)
       b1 = 3; b2 = 1; b3 = 0;
   end
   w = omega(thresh3) - omega(thresh1);
   thresh = floor(thresh1*(omega(thresh1)+0.25*w*b1) + 0.25*thresh2*w*b2 + thresh3*(1-omega(thresh3)+0.25*w*b3));
   b_img = img >= thresh;
    
end

