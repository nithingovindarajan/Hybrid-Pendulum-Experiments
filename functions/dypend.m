function dy = dypend(t,y)
    global g l 
    dy = zeros(2,1);
    dy(1) = y(2);
    dy(2) = -g/l*sin(y(1));
end
