function [ b_img thresh ] = th_shape_rosenfeld( img, n )
%TH_SHAPE_ROSENFELD Find a global threshold for a grayscale image 
% by choosing the threshold to be in the shoulder of the histogram.
%
% Input:
%   img: gray image
%     n: number of bins (defaults to 256)
% Output:
%   b_img: binarized image
%   thresh: threshold
%
% Reference:
%   A. Rosenfeld and P. De La Torre, "Histogram concavity analysis as an aid
%   in threshold selection," IEEE Transactions on Systems, Man, and
%   Cybernetics, vol. 13, pp. 231-235, 1983.
%
%  Written by Liang Tan (liangtan@zju.edu.cn), 2013/11/27
% 

    if nargin == 1
        n = 256;
    end
    
    % Calculate the histogram and its convex hull.
    h = imhist(img,n);
    H = hconvhull(h);
    
    % Find the local maxima of the difference H-h.
    diff = H-h;
    lmax = zeros(n,1);
    for k = 2:n-1
        if diff(k) > diff(k-1) && diff(k) > diff(k+1)
            lmax(k) = 1;
        end
    end
    
    % Find the histogram balance around each index.
    E = zeros(n,1);
    sm = sum(h);
    cmsm = cumsum(h);
    for k = 1:n
        E(k) = cmsm(k) * (sm - cmsm(k));
    end
    
    % The threshold is the local maximum with highest balance.
    E = E.*lmax;
    [~, ind] = max(E);
    thresh = ind-1;
    
    % Binarized image
    b_img = img >= thresh;

end

