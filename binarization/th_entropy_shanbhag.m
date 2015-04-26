function [ b_img, thresh ] = th_entropy_shanbhag( img, n )
%TH_ENTROPY_SHANBHAG  Global image threshold using fuzzy entropy.
%
% Input:
%   img: gray image
%     n: number of bins (defaults to 256)
% Output:
%   b_img: binarized image
%   thresh: threshold
%
% Reference:
%   Shanbhag, Abhijit G. (1994), "Utilization of information measure as a 
%   means of image thresholding", Graph. Models Image Process. (Academic 
%   Press, Inc.) 56 (5): 414--419, ISSN 1049-9652, DOI 10.1006/cgip.1994.1037

%
%  Written by Liang Tan (liangtan@zju.edu.cn), 2013/11/28
% 

    if nargin == 1
        n = 256;
    end

    gray_hist = imhist(img,n);
    p = gray_hist / sum(gray_hist);
    omega = cumsum(p);
    
    % Search for gray threshold
   thresh = 0;
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
       
       % foreground
       hf = 0;
       for j=1:i-1
           hf = hf + p(j)*log(1-0.5*omega(j)/p1);
       end
       hf = hf / p1;
       
       % background
       hb = 0;
       for j=i+1:n
           hb = hb + p(j)*log(0.5*(1+(omega(j)-omega(i))/p2));
       end
       hb = hb / p2;
       
       ht = abs(hf - hb);
       if hm > ht
           hm = ht;
           thresh = i;
       end
       
   end
   
   thresh = thresh - 1;
   b_img = img >= thresh;

end
