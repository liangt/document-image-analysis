function b_img = kfill( b_img, k, max_iter )
%KFILL kFill filter for text images  to reduce salt-and-pepper noise 
% while maintaining readability
%
% Input:
%   b_img: binary image
%       k: k-filling parameter, default value is 3
%   max_iter: maximum iterations, default value is 10
% Output:
%   b_img: binary image after reducing salt-and-pepper noise
%
% Reference:
%  L. O¡¯Gorman. "Image and document processing techniques for the 
%  right pages electronic library system". ICPR, 2:260¨C263, 1992.
%  G.A. Story, L. O¡¯Gorman, D. Fox, L.L. Schaper, and H.V. Jagadish, 
%  "The rightpages image-based electronic library for alerting and browsing", 
%  Computer, vol.25,no.9, pp.17¨C26, 1992.
%
%  Written by Liang Tan (liangtan@zju.edu.cn), 2013/11/15
% 

    if nargin == 2
        max_iter = 10;
    elseif nargin == 1
        k = 3;
        max_iter = 10;
    end
    [h w] = size(b_img);
    npc = (k - 2) * (k - 2);  % number of core points
    npp = 4 * (k - 1);        % number of perimeter points
    perimeter = zeros(npp,1);
    
    for t=1:max_iter
        count = 0;
        r_img = b_img;
        
        % Filling salt and pepper noise
        for i=1:h-k+1
            for j=1:w-k+1
                
                sm = 0;
                for ix=i+1:i+k-2
                    for iy=j+1:j+k-2
                        sm = sm + r_img(ix,iy);
                    end
                end
                
                % White filling
                if sm == 0
                    idx = 1;
                    ie = i+k-1;
                    je = j+k-1;
                    for it=j:je
                        perimeter(idx) = r_img(i,it);
                        idx = idx + 1;
                    end
                    for it=i+1:ie
                        perimeter(idx) = r_img(it,je);
                        idx = idx + 1;
                    end
                    for it=je-1:-1:j
                        perimeter(idx) = r_img(ie,it);
                        idx = idx + 1;
                    end
                    for it=ie-1:-1:i+1
                        perimeter(idx) = r_img(it,j);
                        idx = idx + 1;
                    end
                    n = perimeter(1);
                    c = abs(perimeter(1) - perimeter(end));
                    for it=2:npp
                        n = n + perimeter(it);
                        c = c + abs(perimeter(it) - perimeter(it-1));
                    end
                    r = r_img(i,j)+r_img(i,j+k-1)+r_img(i+k-1,j)+r_img(i+k-1,j+k-1);
                    if c<=2 && (n>3*k-4 || (n==3*k-4 && r==2))
                        for ix=i+1:i+k-2
                            for iy=j+1:j+k-2
                                b_img(ix,iy) = 1;
                            end
                        end
                        count = count + 1;
                    end
             
                    continue    
                end
                
                % Black filling
                if sm == npc
                    idx = 1;
                    ie = i+k-1;
                    je = j+k-1;
                    for it=j:je
                        perimeter(idx) = r_img(i,it);
                        idx = idx + 1;
                    end
                    for it=i+1:ie
                        perimeter(idx) = r_img(it,je);
                        idx = idx + 1;
                    end
                    for it=je-1:-1:j
                        perimeter(idx) = r_img(ie,it);
                        idx = idx + 1;
                    end
                    for it=ie-1:-1:i+1
                        perimeter(idx) = r_img(it,j);
                        idx = idx + 1;
                    end
                    n = npp - perimeter(1);
                    c = abs(perimeter(1) - perimeter(end));
                    for it=2:npp
                        n = n - perimeter(it);
                        c = c + abs(perimeter(it) - perimeter(it-1));
                    end
                    r = r_img(i,j)+r_img(i,j+k-1)+r_img(i+k-1,j)+r_img(i+k-1,j+k-1);
                    if c<=2 && (n>3*k-4 || (n==3*k-4 && r==2))
                        for ix=i+1:i+k-2
                            for iy=j+1:j+k-2
                                b_img(ix,iy) = 0;
                            end
                        end
                        count = count + 1;
                    end
                end
                
            end
        end
        
        if count == 0
            break
        end
        
    end

end