function [ b_img, thresh ] = th_shape_prewitt( img, n )
%TH_SHAPE_PREWITT Global image threshold using Ramesh's method.
%
% Input:
%   img: gray image
%     n: number of bins (defaults to 256)
% Output:
%   b_img: binarized image
%   thresh: threshold
%
% Reference:
%   J. M. S. Prewitt and M. L. Mendelsohn, "The analysis of cell images," in
%   Annals of the New York Academy of Sciences, vol. 128, pp. 1035-1053, 1966.
%
%  Written by Liang Tan (liangtan@zju.edu.cn), 2013/11/28
% 

    if nargin == 1
        n = 256;
    end
    
    y = imhist(img,n);
    thresh = 0;
    
    % Smooth the histogram by iterative three point mean filtering.
    iter = 0;
    h = ones(1,3)/3;
    while ~bimodtest(y)
        y = conv2(y,h,'same');
        iter = iter+1;
        
        % If the histogram turns out not to be bimodal, set T to zero.
        if iter > 10000;   
            return
        end
        
    end
    
    % The threshold is the mean of the two peaks of the histogram.
    for k = 2:n
        if y(k-1) < y(k) && y(k+1) < y(k)
            thresh = thresh + k-1;
        end
    end
    thresh = floor(thresh/2);
    
    b_img = img > thresh;
    
end

