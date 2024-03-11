function [yBDF3,t] = BDF3(A, B, C, D, u, h, tend, x0)
% Usage of BE with 1x interation to obtain fi+1

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

for t = 0:h:tend-h

    if i < 3 % Use implicit BE Algo to calculate first 2 steps
        x(:,i+1) = (eye(size(A,1))-A*h) \ (x(:,i) + B*u*h);
    else
        xip1 = (eye(size(A,1))-A*h) \ (x(:,i) + B*u*h);
        fip1 = A*xip1 + B*u;  % Usage of BE with 1x interation to obtain fi+1

        x(:,i+1) = (18/11)*x(:,i) - (9/11)*x(:,i-1) + (2/11)*x(:,i-2) + (6/11)*h*fip1;
    end

    y(:,i+1) = C*x(:,i+1) + D*u;
    t_vec(i) = t;
    i = i + 1;
end

t = t_vec;
yBDF3 = y;


end