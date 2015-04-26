function b_img = th_local_niblack( img, b, k )
%TH_LOCAL_NIBLACK Local image thresholding using Niblack's method.
%  The method adapts the threshold according to the local mean and 
%  standard deviation and calculated a window size of b*b.
%
% Input:
%   img: gray image
%     b: local window size (defaults to 15)
%     k: bias (defaults to -0.2)
% Output:
%   b_img: binarized image
%
% Reference:
%   W. Niblack, An Introduction to Image Processing, pp. 115¨C116,
%   Prentice-Hall, Englewood Cliffs, NJ (1986).
%
%  Written by Liang Tan (liangtan@zju.edu.cn), 2013/11/28
% 

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
            td = sm + k * sqrt(double(sd));
            idx = i+hf_s;
            idy = j+hf_s;
            b_img(idx,idy) = img(idx,idy) > td;
        end
    end
    
end

