function b = bimodtest(y)
% BIMODTEST Test if a histogram is bimodal.
%
% Input:
%     y: histogram
% Output:
%     b: true if histogram is bimodal, false otherwise
%
%  Written by Liang Tan (liangtan@zju.edu.cn), 2013/11/27
%

len = length(y);
b = false;
modes = 0;

% Count the number of modes of the histogram in a loop. If the number
% exceeds 2, return with boolean return value false.
for k = 2:len-1
  if y(k-1) < y(k) && y(k+1) < y(k)
    modes = modes+1;
    if modes > 2
      return
    end
  end
end

% The number of modes could be less than two here
if modes == 2
  b = true;
end
