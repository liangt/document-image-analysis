function [txt_img g_img] = rlsa_seg( b_img, sg_blks, c1, c2 )
%RLSA_SEG Document Segmentation by RLSA. 
%
% Input:
%   b_img: binary image, 1 -- background pixel, 0 -- foreground pixel
%   sg_blks: segmented blocks, a cell array
%      Attributes of each element:
%         bc: total number of black pixels in a segmented block 
%         x_min: Minimum x coordinate of a block 
%         y_min: Minimum y coordinate of a block
%         delta_x: x length
%         delta_y: y length
%         dc: total number of black pixels in original data from the block 
%         tc: Horizontal white-black transitions of original data
%   c1: predefined constant, default value is 3 
%   c2: predefined constant, default value is 3
% Output:
%   txt_img: text block of original document image b_img
%     g_img: image block of original document image b_img
%
% Reference:
%  K.Y. Wong, R.G. Casey and F.M. Wahl, "Docuinent analysis system," 
%  IBM J. Res. Devel., Vol. 26, NO. 6,111). 647-656, 1982.
%
%  Written by Liang Tan (liangtan@zju.edu.cn), 2013/11/19
% 

    if nargin < 4
        c2 = 3;
    end
    if nargin < 3
        c1 = 3;
    end
    num = length(sg_blks);
    avg_r = 0;
    avg_h = 0;
    for i=1:num
        avg_h = avg_h + sg_blks{i}.delta_y;
        avg_r = avg_r + sg_blks{i}.dc / sg_blks{i}.tc;
    end
    avg_h = avg_h / num;
    avg_r = avg_r / num;
    th_h = c2 * avg_h;
    th_r = c1 * avg_r;
    
    [r c] = size(b_img);
    txt_img = ones(r,c);
    g_img = txt_img;
    for i=1:num
        x_mn = sg_blks{i}.x_min;
        y_mn = sg_blks{i}.y_min;
        x_mx = x_mn + sg_blks{i}.delta_x;
        y_mx = y_mn + sg_blks{i}.delta_y;
        if sg_blks{i}.delta_y < th_h && sg_blks{i}.dc/sg_blks{i}.tc < th_r
            txt_img(x_mn:x_mx,y_mn:y_mx) = b_img(x_mn:x_mx,y_mn:y_mx);
        else
            g_img(x_mn:x_mx,y_mn:y_mx) = b_img(x_mn:x_mx,y_mn:y_mx);
        end
    end

end

