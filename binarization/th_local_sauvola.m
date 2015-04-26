function b_img = th_local_sauvola( img, b, k, r )
%TH_LOCAL_SAUVOLA Local image thresholding using Sauvola's method.
%  The method adapts the threshold according to the local mean and 
%  standard deviation and calculated a window size of b*b.
%
% Input:
%   img: gray image
%     b: local window size (defaults to 15)
%     k: bias (defaults to 0.5)
%     r: radius (defaults to 128)
% Output:
%   b_img: binarized image
%
% Reference:
%   J. Sauvola and M. Pietaksinen, 'Adaptive document image binarization,'
%   Pattern Recogn. 33, 225¨C236 (2000).
%
%  Written by Liang Tan (liangtan@zju.edu.cn), 2013/11/28
% 

    if nargin < 4
        r = 128;
    end
    if nargin < 3
        k = -0.2;
    end
    if nargin < 2
        b = 15;
    end
    
    [n m] = size(img);
    b_img = true(n,m);
    hf_s = floor(b/2);
    
    sz = b * b;
    b = b - 1;
    n = n - b;
    m = m - b;
    for i=1:n
        for j=1:m
            sm = 0;
            sd = 0;
            x_ed = i + b;
            y_ed = j + b;
            for ix=i:x_ed
                for iy=j:y_ed
                    sm = sm + img(ix,iy);
                    sd = sd + img(ix,iy) * img(ix,iy);
                end
            end
            sm = sm / sz;
            sd = sd / sz - sm * sm;
            td = sm + 1 + k * (sqrt(double(sd))/r - 1);
            idx = i+hf_s;
            idy = j+hf_s;
            b_img(idx,idy) = img(idx,idy) > td;
        end
    end
    
end

