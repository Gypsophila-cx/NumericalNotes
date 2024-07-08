function continfrac
f =@(x) (x+1)^3/(x-1)^4;
% f = @(x) (1+2*x)/(1+3*x+x^2);

n = 4;
% a = [1, 2, 0];
% b = [1, 3, 1];
% a = [1, 3, 3, 1];
for i = 1:n+1
    b(i) = (-1)^(n+1-i) * factorial(n)/(factorial(n+1-i)*factorial(i-1));
end
% d = zeros(4, 3);
% d(1,:) = b;
% d(2,:) = a;
% [M,~] = size(d);

% for i = 3:M
%     for j = 1:M+1-i
%         d(i,j) = d(i-1,1)*d(i-2,j+1) - d(i-2,1)*d(i-1,j+1);
%     end
% end

d = zeros(6,5);
d(1,:) = b;
d(2,:) = [1,3,3,1,0];
for i = 3:n+2
    for j = 1:n+3-i
        d(i,j) = d(i-1,1)*d(i-2,j+1) - d(i-2,1)*d(i-1,j+1);
    end
end
d
d = d(:, 1);
x = linspace(2, 6, 100);
for i = 1:100
    y1(i) = f(x(i));
    y2(i) = Efrac(d, x(i));
end
plot(x, y1, 'o', x, y2, 'x')

function y = frac(d, x)
y = d(end)/d(end-1);
for k = length(d)-1:-1:2
    y = d(k)/(d(k-1)+x*y);
end

function y = Efrac(d, x)
a = [d(2:end); 0];
b = d;
a(2:end) = x*a(2:end);
A0 = 0; A1 = a(1);
B0 = 1; B1 = b(1);
for i = 3:length(d)+1
    A2 = b(i-1)*A1 + a(i-1)*A0;
    A0 = A1; A1 = A2;
    B2 = b(i-1)*B1 + a(i-1)*B0;
    B0 = B1; B1 = B2;
end
y = A1/B1;