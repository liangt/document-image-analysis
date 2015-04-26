x = randi(2,[100,1])-1;

max_len = 0;
mst = 1;
med = 1;
st = 1;
len = 0;
for i=1:100
    if x(i)
        if len > max_len
            mst = st;
            med = i - 1;
            max_len = len;
        end
        len = 0;
        st = i + 1;
    else
        len = len + 1;
    end
end