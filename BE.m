function [yBE,t] = BE(A, B, C, D, u, h, tend, x0)

i = 1;
%Create empty Array that match the dimension for the possible state
%variables
x = zeros(length(A),length(0:h:tend));
y = zeros(size(C,1),length(0:h:tend));

%Inital value mapping
startValue = zeros(1,length(A))';
startValue(:) = x0;
x(:,1) = startValue;
y(:,1) = C*x(:,1) + D*u;

%Implementaion for Matrix
for t_act = 0:h:tend-h
    
    x(:,i+1) = inv(1-A*h) * (x(:,i) + B*u*h);
    y(:,i+1) = C*x(:,i+1) + D*u;

    t_vec(i) = t_act;
    i = i + 1;
end

t = t_vec;
yBE = y;

end