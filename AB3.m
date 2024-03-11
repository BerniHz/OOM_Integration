function [yAB3,t] = AB3(A, B,C, D, u, h, tend, x0)

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

    if i < 3 % Use explicit RK4 Algo to calculate first 2 steps
        %Step0
        dx_dt = A*x(:,i) + B*u;
        %Step1
        xP1 = x(:,i) + h/2 * dx_dt;
        dxP1_dt = A*xP1 + B*u;
        %Step2
        xP2 = x(:,i) + h/2 * dxP1_dt;
        dxP2_dt = A*xP2 + B*u;
        %Step3
        xP3 = x(:,i) + h * dxP2_dt;
        dxP3_dt = A*xP3 + B*u;
        x(:,i+1) = x(:,i) + h/6 *(dx_dt + 2*dxP1_dt + 2*dxP2_dt + dxP3_dt);
    else
        fi = A*x(:,i) + B*u;
        fim1 = A*x(:,i-1) + B*u;
        fim2 = A*x(:,i-2) + B*u;

        x(:,i+1) = x(:,i) + h/12 * (23*fi - 16*fim1 + 5*fim2);
    end

    y(:,i+1) = C*x(:,i+1) + D*u;
    t_vec(i) = t;
    i = i + 1;
end

t = t_vec;
yAB3 = y;

end