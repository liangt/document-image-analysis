function b_img = filter1( b_img, max_iter )
%FILTER1 A filter to smooth the edges and remove the small pieces of noise
%  Mask:
%    = = =      x = =     x x x      = = x
%    = T =      x T =     = T =      = T x
%    x x x      x = =     = = =      = = x
%
% Input:
%   b_img: binary image
%   max_iter: maximum iterations, default value is 10
% Output:
%   b_img: binary image after filting
%
% Reference:
%  Mohamed Cheriet, Nawwaf Kharma, ChengLin Liu, Ching Y.Suen,
%  Character Recognition System: A Guide for Students and Practitioners
%
%  Written by Liang Tan (liangtan@zju.edu.cn), 2013/11/18
% 

    if nargin == 1
        max_iter = 10;
    end
    [h w] = size(b_img);
    
    for t=1:max_iter
        count = 0;
        r_img = b_img;
        
        for i=1:h-k+1
            for j=1:w-k+1
                
                % Mask 1
                sm = r_img(i+1,j) + r_img(i,j) + r_img(i,j+1) + r_img(i,j+2) + r_img(i+1,j+2);
                if sm == 5
                    b_img(i+1,j+1) = 1;
                    count = count + 1;
                    continue
                end
                if sm == 0
                    b_img(i+1,j+1) = 0;
                    count = count + 1;
                    continue
                end
                
                % Mask 2
                sm = r_img(i,j+1) + r_img(i,j+2) + r_img(i+1,j+2) + r_img(i+2,j+2) + r_img(i+2,j+1);
                if sm == 5
                    b_img(i+1,j+1) = 1;
                    count = count + 1;
                    continue
                end
                if sm == 0
                    b_img(i+1,j+1) = 0;
                    count = count + 1;
                    continue
                end
                
                % Mask 3
                sm = r_img(i+1,j) + r_img(i+2,j) + r_img(i+2,j+1) + r_img(i+2,j+2) + r_img(i+1,j+1);
                if sm == 5
                    b_img(i+1,j+1) = 1;
                    count = count + 1;
                    continue
                end
                if sm == 0
                    b_img(i+1,j+1) = 0;
                    count = count + 1;
                    continue
                end
                
                % Mask 4
                sm = r_img(i,j+1) + r_img(i,j) + r_img(i+1,j) + r_img(i+2,j) + r_img(i+2,j+1);
                if sm == 5
                    b_img(i+1,j+1) = 1;
                    count = count + 1;
                    continue
                end
                if sm == 0
                    b_img(i+1,j+1) = 0;
                    count = count + 1;
                    continue
                end
                
            end
        end
        
        if count == 0
            break
        end
        
    end

end
