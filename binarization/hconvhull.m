function H = hconvhull(h)
% HCONVHULL Find the convex hull of a histogram.
%
% Input:
%   h: histogram
% Output:
%   H: convex hull of histogram
%
%  Written by Liang Tan (liangtan@zju.edu.cn), 2013/11/27
% 

    len = length(h);
    K(1) = 1;
    k = 1;

    % The vector K gives the locations of the vertices of the convex hull.
    while K(k)~=len
        theta = zeros(1,len-K(k));
        for i = K(k)+1:len
            x = i-K(k);
            y = h(i)-h(K(k));
            theta(i-K(k)) = atan2(y,x);
        end

        maximum = max(theta);
        maxloc = find(theta==maximum);
        k = k+1;
        K(k) = maxloc(end)+K(k-1);
    end

    % Form the convex hull.
    H = zeros(len,1);
    for i = 2:length(K)
        H(K(i-1):K(i)) = h(K(i-1))+(h(K(i))-h(K(i-1)))/(K(i)-K(i-1))*(0:K(i)-K(i-1));
    end
    
end
