x  = 13;

tic
for t=1:100
for i=0:99
    for j=0:99
        a = x^2;
    end
end
end
toc

tic
for t=1:100
for i=0:99
    for j=0:99
        a = x * x;
    end
end
end
toc