% y'=-y, y(0)=1, x\in [0,1]
% Euler method

function Euler_sum
for r = 0:16
    n = 10^(r/2);
    e1(r+1) = classic(n) - exp(-1);
    e2(r+1) = compensation(n) - exp(-1);
end
loglog(10.^(0:0.5:8), abs(e1), 'o-','LineWidth',1.2)
hold on
loglog(10.^(0:0.5:8), abs(e2), 'x-','LineWidth',1.2)
grid on
legend('Without Compentation', 'With Compentation')
xlabel('\bfn')
ylabel('\bfabsolute error')

% Classic summation
function y = classic(n)
h = single(1/n);
y = single(1);
for i = 1:n
    y = y - h*y;
end

function y = compensation(n)
h = single(1/n);
y = single(1);
cy = single(0);
for i = 1:n
    dy = cy - h*y;
    newy = y + dy;
    cy = (y - newy) + dy;
    y = newy;
end