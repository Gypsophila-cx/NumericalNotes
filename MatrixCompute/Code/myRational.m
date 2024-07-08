function myRational
% f(x) = (x+1)^3/(x-1)^n
x = 1.11;
N = 30;
for n = 1:N
    a = [1, 3, 3, 1];
    for i = 1:n+1
        b(i) = (-1)^(n+1-i) * factorial(n)/(factorial(n+1-i)*factorial(i-1));
    end
    p1 = Horner(a, x); p2 = ComHorner(a, x);
    q1 = Horner(b, x); q2 = ComHorner(b, x);
    y = (x+1)^3/(x-1)^n;
    e1(n) = (y - p1/q1)/y;
    e2(n) = (y - p2/q2)/y;
end

cond = 1 + (abs(1+x)/abs(1-x)).^(1:N);

loglog(cond, abs(e1), 'bo-', 'LineWidth', 1)
hold on
loglog(cond, abs(e2), 'rx-', 'LineWidth', 1)
grid on
axis([1e1, 1e35, 1e-17, 1e2])
xlabel('\bfcondtion number')
ylabel('\bfRelative Error')
legend('Classic Horner', 'Compensated Horner')

function y = Horner(a, x)
% classic Horner's method without compensation
q = a(end);
for k = length(a)-1:-1:1
   q = q*x + a(k);
end
y = q;

function y = ComHorner(a, x)
% Horner's method with compensation
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
s = 27; % double format
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