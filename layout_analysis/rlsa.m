function [ bsg_img sg_blks] = rlsa( b_img, hsv, vsv, ahsv )
%RLSA Run-length Smoothing Algorithm
%
% Input:
%   b_img: binary image, 1 -- background pixel, 0 -- foreground pixel
%     hsv: horizental smoothing value
%     vsv: vertical smoothing value
%     ahsv: additional horizontal smoothing value
% Output:
%   bsg_img: block segmentation image
%   sg_blks: segmented blocks, a cell array
%      Attributes of each element:
%         bc: total number of black pixels in a segmented block 
%         x_min: Minimum x coordinate of a block 
%         y_min: Minimum y coordinate of a block
%         delta_x: x length
%         delta_y: y length
%         dc: total number of black pixels in original data from the block 
%         tc: Horizontal white-black transitions of original data
%
% Reference:
%  K.Y. Wong, R.G. Casey and F.M. Wahl, "Docuinent analysis system," 
%  IBM J. Res. Devel., Vol. 26, NO. 6,111). 647-656, 1982.
%
%  Written by Liang Tan (liangtan@zju.edu.cn), 2013/11/19
% 

    [row col] = size(b_img);
    row_img = b_img;
    col_img = b_img;

    % Horizontal smoothing
    for i=1:row
        j = 1;
        while j<=col-hsv
            for t=j:j+hsv
                if b_img(i,t) == 0
                    for idx = j:t
                        row_img(i,idx) = 0;
                    end
                    break
                end
            end
            j = t+1;
        end
    end
    
    % Vertical smoothing
    for i=1:col
        j = 1;
        while j<=row-vsv
            for t=j:j+vsv
                if b_img(t,i) == 0
                    for idx = j:t
                        col_img(idx,i) = 0;
                    end
                    break
                end
            end
            j = t+1;
        end
    end
    
    bsg_img = row_img | col_img;
    
    % Additional horizontal smoothing
    for i=1:row
        j = 1;
        while j<=col-ahsv
            for t=j:j+ahsv
                if bsg_img(i,t) == 0
                    for idx = j:t
                        bsg_img(i,idx) = 0;
                    end
                    break
                end
            end
            j = t+1;
        end
    end
    
    % Block Label
    [l num] = bwlabel(~bsg_img,8);
    sg_blks = cell(num,1);
    for i=1:num
        [r c] = find(l == i);
        n = length(r);
        sg_blks{i}.bc = n;
        x_mn = min(r);
        y_mn = min(c);
        x_mx = max(r);
        y_mx = max(c);
        sg_blks{i}.x_min = x_mn;
        sg_blks{i}.y_min = y_mn;
        sg_blks{i}.delta_x = x_mx - x_mn;
        sg_blks{i}.delta_y = y_mx - y_mn;
        sm = n;
        for j=1:n
            sm = sm - b_img(r(j),c(j));
        end
        sg_blks{i}.dc = sm;
        sm = 1;
        for ix = x_mn:x_mx
            for iy=y_mn+1:y_mx
                sm = sm + xor(b_img(ix,iy),b_img(ix,iy-1));
            end
        end
        sg_blks{i}.tc = sm;
    end
    
end

