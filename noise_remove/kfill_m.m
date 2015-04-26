function r_img = kfill_m( b_img, k )
%KFILL_M A single iteration filter based on kFill filter
%
% Input:
%   b_img: binary image
%       k: k-filling parameter, default value is 3
% Output:
%   r_img: binary image after reducing salt-and-pepper noise
%
% Reference:
%  K. Chinnasarn, Y. Rangsanseri, and P. Thitimajshima,
%  "Removing salt-and-pepper noise in text/graphics images", 
%  The 1998 IEEE Asia-Pacific Conference on Circuits and Systems,
%  Chiangmai, pp.459¨C462, 1998.
%
%  Written by Liang Tan (liangtan@zju.edu.cn), 2013/11/15
% 

    if nargin == 1
        k = 3;
    end
    [h w] = size(b_img);
    npp = 4 * (k - 1);        % number of perimeter points
    perimeter = zeros(npp,1);
    r_img = b_img;
    
    % Filling salt and pepper noise
    for i=1:h-k+1
        for j=1:w-k+1
            
            % count #ON within the core
            sm = 0;
            for ix=i+1:i+k-2
                for iy=j+1:j+k-2
                    sm = sm + b_img(ix,iy);
                end
            end
            
            if sm >= (k-2)*(k-2)/2
                % Black filling
                idx = 1;
                ie = i+k-1;
                je = j+k-1;
                for it=j:je
                    perimeter(idx) = b_img(i,it);
                    idx = idx + 1;
                end
                for it=i+1:ie
                    perimeter(idx) = b_img(it,je);
                    idx = idx + 1;
                end
                for it=je-1:-1:j
                    perimeter(idx) = b_img(ie,it);
                    idx = idx + 1;
                end
                for it=ie-1:-1:i+1
                    perimeter(idx) = b_img(it,j);
                    idx = idx + 1;
                end
                n = npp - perimeter(1);
                c = abs(perimeter(1) - perimeter(end));
                for it=2:npp
                    n = n - perimeter(it);
                    c = c + abs(perimeter(it) - perimeter(it-1));
                end
                r = b_img(i,j)+b_img(i,j+k-1)+b_img(i+k-1,j)+b_img(i+k-1,j+k-1);
                if c<=2 && (n>3*k-4 || (n==3*k-4 && r==2))
                    for ix=i+1:i+k-2
                        for iy=j+1:j+k-2
                            r_img(ix,iy) = 0;
                        end
                    end
                else
                    for ix=i+1:i+k-2
                        for iy=j+1:j+k-2
                            r_img(ix,iy) = 1;
                        end
                    end
                end
            else
                % White filling
                idx = 1;
                ie = i+k-1;
                je = j+k-1;
                for it=j:je
                    perimeter(idx) = b_img(i,it);
                    idx = idx + 1;
                end
                for it=i+1:ie
                    perimeter(idx) = b_img(it,je);
                    idx = idx + 1;
                end
                for it=je-1:-1:j
                    perimeter(idx) = b_img(ie,it);
                    idx = idx + 1;
                end
                for it=ie-1:-1:i+1
                    perimeter(idx) = b_img(it,j);
                    idx = idx + 1;
                end
                n = perimeter(1);
                c = abs(perimeter(1) - perimeter(end));
                for it=2:npp
                    n = n + perimeter(it);
                    c = c + abs(perimeter(it) - perimeter(it-1));
                end
                r = b_img(i,j)+b_img(i,j+k-1)+b_img(i+k-1,j)+b_img(i+k-1,j+k-1);
                if c<=2 && (n>3*k-4 || (n==3*k-4 && r==2))
                    for ix=i+1:i+k-2
                        for iy=j+1:j+k-2
                            r_img(ix,iy) = 1;
                        end
                    end
                else
                    for ix=i+1:i+k-2
                        for iy=j+1:j+k-2
                            r_img(ix,iy) = 0;
                        end
                    end
                end
            end
        end
    end

end