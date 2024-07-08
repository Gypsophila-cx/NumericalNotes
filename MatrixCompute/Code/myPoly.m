function myPoly
% Test polynomial: p(x) = (x-2)^3 = -8 + 3*4*x + 3*(-2)*x^2 + x^3
p = @(x) (x-2).^3;

a = [-8, 12, -6, 1];
x = 2-0.01:0.0002:2+0.01;
for i = 1:length(x)
    y1(i) = Horner(a, x(i));
    y2(i) = ComHorner(a, x(i));
end
figure(1)
plot(x, p(x), 'k', 'LineWidth', 1.5)
%plot(x, polyval(a(end:-1:1), single(x)), 'k', 'LineWidth', 1.5)
hold on
plot(x, y1, 'bo-', x, y2, 'rx')
axis([1.99, 2.01, -2.5e-6, 2.5e-6])
xlabel('\bfx')
ylabel('\bfy')
legend('Exact', 'Classic Horner', 'Compensated Horner')

figure(2)
semilogy(x, abs(y1-p(x)),'bo-', x, abs(y2-p(x)), 'rx-')
grid on
xlabel('\bfx')
ylabel('\bfAbsoulte Error')
legend('Classic Horner', 'Compensated Horner')

function y = Horner(a, x)
% classic Horner's method without compensation
a = single(a);
x = single(x);
q = a(end);
for k = length(a)-1:-1:1
   q = q*x + a(k);
end
y = q;

function y = ComHorner(a, x)
% Horner's method with compensation
a = single(a);
x = single(x);
q = a(end);
r = 0;
for k = length(a)-1:-1:1
    [p, theta] = TwoProduct(q, x);
    [q, sigma] = TwoSum(p, a(k));
    r = (theta + sigma) + r*x;
end
y = q + r;

function [x, y] = TwoSum(a, b)
% a+b = x+y
x = a + b;
z = x - a;
y = (a-(x-z)) + (b-z);

function [x, y] = Split(a)
% a = x+y
s = 12; % single format
factor = 2^s + 1;
c = factor * a;
x = c - (c - a);
y = a - x;

function [x, y] = TwoProduct(a, b)
% a*b = x+y
x = a * b;
[a1, a2] = Split(a);
[b1, b2] = Split(b);
y = a2*b2 - (((x - a1*b1)-a2*b1)-a1*b2);