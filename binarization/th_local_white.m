function [ output_args ] = th_local_white( img, b, k )
%TH_LOCAL_WHITE Local image thresholding using Sauvola's method.
%  The method adapts the threshold according to the local mean and 
%  standard deviation and calculated a window size of b*b.
%
% Input:
%   img: gray image
%     b: local window size (defaults to 15)
%     k: bias (defaults to 2)
% Output:
%   b_img: binarized image
%
% Reference:
%   J. M. White and G. D. Rohrer, 'Image thresholding for optical character
%   recognition and other applications requiring character image extraction,'
%   IBM J. Res. Dev. 27~4!, 400¨C411 (1983).
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
            x_ed = i + b;
            y_ed = j + b;
            for ix=i:x_ed
                for iy=j:y_ed
                    sm = sm + img(ix,iy);
                end
            end
            sm = sm / sz;
            b_img(idx,idy) = img(idx,idy)*k >= sm;
        end
    end
    
end