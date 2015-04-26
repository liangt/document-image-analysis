function [ m_len m_st m_ed ] = max_zero_string( b_hist )
%MAX_ZERO_STRING Find the largest zero substring
%
% Input:
%   b_hist: pixel projection profile histogram
% Output:
%   m_len: the length of largest zero substring 
%    m_st: start position of largest zero substring 
%    m_ed: end position of largest zero substring
%
%  Written by Liang Tan (liangtan@zju.edu.cn), 2013/11/22

    m_st = 1;
    m_ed = 1;
    m_len = 0;
    st = 1;
    len = 0;
    n = length(b_hist);
    for i=1:n
        if b_hist(i) > 0
            if len > m_len
                m_st = st;
                m_ed = i - 1;
                m_len = len;
            end
            len = 0;
            st = i + 1;
        else
            len = len + 1;
        end
    end

end

