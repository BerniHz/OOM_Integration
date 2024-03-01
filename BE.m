function [yBE,t] = BE(A, b, c, d, u, h, tend, x0)

i = 1;
x = zeros(size(0:h:tend));
x(i) = x0;

for t_act = 0:h:tend-h
    %BE
    x(i+1) = (1-A*h)^-1 * x(i)

    t_vec(i) = t_act;
    i = i + 1;
end

t = t_vec;
yFE = x;



end