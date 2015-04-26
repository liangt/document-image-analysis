function doc_tree = xycut( b_img, tnx, tny, tcx, tcy )
%XYCUT XY-Cut Algorithm.
%
% Input:
%   b_img: binary image, 0 -- background pixel, 1 -- foreground pixel
%     tnx: noise threshold on projection on x-axis, default value is 32
%     tny: noise threshold on projection on y-axis, default value is 78
%     tcx: min gap size on x-axis projection, default value is 54
%     tcy: min gap size on y-axis projection, default value is 35
% Output:
%   doc_tree: document tree
%      Attributes of each node:
%         x_min: Minimum x coordinate of a block
%         x_max: Maximum x coordinate of a block
%         y_min: Minimum y coordinate of a block
%         y_max: Maximum x coordinate of a block
%         l_child: left child node
%         r_child: right child node
% Reference:
%  S. Mao and T. Kanungo, "Empirical performance evaluation methodology and its 
%  application to page segmentation algorithms," IEEE Transactions on Pattern 
%  Analysis and Machine Intelligence 23, pp. 242-256, 2001.
%
%  Written by Liang Tan (liangtan@zju.edu.cn), 2013/11/22
% 

    if nargin < 5
        tcy = 32;
    end
    if nargin < 4
        tcx = 54;
    end
    if nargin < 3
        tny = 78;
    end
    if nargin < 2
        tnx = 35;
    end

    %% Mao, Fig.3: Step 1.
    % Create the horizontal and vertical prefix-sum tables HX and HY
    [row col] = size(b_img);
    hx = zeros(row,col);
    hy= hx;
    for i=1:row
        hx(i,1) = b_img(i,1);
        for j=2:col
            hx(i,j) = hx(i,j-1) + b_img(i,j);
        end
    end
    for i=1:col
        hy(1,i) = b_img(1,i);
        for j=2:row
            hy(j,i) = hy(j-1,i) + b_img(j,i);
        end
    end
    
    %% Mao, Fig.3: Step 2.
    factor_tnx = tnx / row ;
    factor_tny = tny / col ;
    
    % Root
    doc_tree{1}.x_min = 1;
    doc_tree{1}.x_max = row;
    doc_tree{1}.y_min = 1;
    doc_tree{1}.y_max = col;
    doc_tree{1}.left = 0;
    doc_tree{1}.right = 0;
    
    % XY_Cut Process
    queue = 1;   % nodes queue
    count = 1;   % number of nodes
    while ~isempty(queue)
        idx = queue(1);
        queue(1) = [];
        
        %% Mao. Fig.3. 2.a)
        % Compute horizontal and vertical projection profiles for a given rectangle
        if doc_tree{idx}.y_min > 1
            px = hx(doc_tree{idx}.x_min:doc_tree{idx}.x_max,doc_tree{idx}.y_max) - hx(doc_tree{idx}.x_min:doc_tree{idx}.x_max,doc_tree{idx}.y_min-1);
        else
            px = hx(doc_tree{idx}.x_min:doc_tree{idx}.x_max,doc_tree{idx}.y_max);
        end
        if doc_tree{idx}.x_min > 1
            py = hy(doc_tree{idx}.x_max,doc_tree{idx}.y_min:doc_tree{idx}.y_max) - hy(doc_tree{idx}.x_min-1,doc_tree{idx}.y_min:doc_tree{idx}.y_max);
        else
            py = hy(doc_tree{idx}.x_max,doc_tree{idx}.y_min:doc_tree{idx}.y_max);
        end
        
        %% Mao. Fig.3. 2.b) & 2.c)
        % shrinking
        x_d = doc_tree{idx}.x_max - doc_tree{idx}.x_min + 1;
        y_d = doc_tree{idx}.y_max - doc_tree{idx}.y_min + 1;
        i = 1;
        while px(i) <= 0 && i < x_d
            i = i + 1;
        end
        doc_tree{idx}.x_min = doc_tree{idx}.x_min + i - 1;
        i = x_d;
        while px(i) <= 0 && i > 0
            i = i - 1;
        end
        doc_tree{idx}.x_max = doc_tree{idx}.x_max - x_d + i;
        i = 1;
        while py(i) <= 0 && i < y_d
            i = i + 1;
        end
        doc_tree{idx}.y_min = doc_tree{idx}.y_min + i - 1;
        i = y_d;
        while py(i) <= 0 && i > 0
            i = i - 1;
        end
        doc_tree{idx}.y_max = doc_tree{idx}.y_max - y_d + i;
        
        % cleaning
        px = px - floor(factor_tny * (doc_tree{idx}.y_max - doc_tree{idx}.y_min + 1)); 
        py = py - floor(factor_tnx * (doc_tree{idx}.x_max - doc_tree{idx}.x_min + 1)); 
        
        %% Mao. Fig.3. 2.d)
        %  returns the widest non-starting or ending white gape of the two projection profiles
        [ ~, xm_st xm_ed ] = max_zero_string( px );
        [ ~, ym_st ym_ed ] = max_zero_string( py );
        
        %% Mao. Fig.3. 2.f)
        x_dis = xm_ed - xm_st + 1;
        y_dis = ym_ed - ym_st + 1;
        if x_dis > tcx && (x_dis >= y_dis || y_dis <= tcy)
            x_mid =  floor((doc_tree{idx}.x_min+doc_tree{idx}.x_max)/2);
            
            % left child 
            count = count + 1;
            doc_tree{idx}.left = count;
            queue = [queue count];
            doc_tree{count}.x_min = doc_tree{idx}.x_min;
            doc_tree{count}.x_max = x_mid;
            doc_tree{count}.y_min = doc_tree{idx}.y_min;
            doc_tree{count}.y_max = doc_tree{idx}.y_max;
            doc_tree{count}.left = 0;
            doc_tree{count}.right = 0;
            
            % right child 
            count = count + 1;
            doc_tree{idx}.right = count;
            queue = [queue count];
            doc_tree{count}.x_min = x_mid + 1;
            doc_tree{count}.x_max = doc_tree{idx}.x_max;
            doc_tree{count}.y_min = doc_tree{idx}.y_min;
            doc_tree{count}.y_max = doc_tree{idx}.y_max;
            doc_tree{count}.left = 0;
            doc_tree{count}.right = 0;
        end
        if y_dis > tcy && (y_dis >= x_dis || x_dis <= tcx)
            y_mid =  floor((doc_tree{idx}.y_min+doc_tree{idx}.y_max)/2);
            
            % left child 
            count = count + 1;
            doc_tree{idx}.left = count;
            queue = [queue count];
            doc_tree{count}.x_min = doc_tree{idx}.x_min;
            doc_tree{count}.x_max = doc_tree{idx}.x_max;
            doc_tree{count}.y_min = doc_tree{idx}.y_min;
            doc_tree{count}.y_max = y_mid;
            doc_tree{count}.left = 0;
            doc_tree{count}.right = 0;
            
            % right child 
            count = count + 1;
            doc_tree{idx}.right = count;
            queue = [queue count];
            doc_tree{count}.x_min = doc_tree{idx}.x_min;
            doc_tree{count}.x_max = doc_tree{idx}.x_max;
            doc_tree{count}.y_min = y_mid + 1;
            doc_tree{count}.y_max = doc_tree{idx}.y_max;
            doc_tree{count}.left = 0;
            doc_tree{count}.right = 0;
        end
        
    end

end

