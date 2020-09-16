A = importdata('case4.txt',',');
x_original = A(:,1);
y_original = A(:,2);
z = 1.96;
n = length(x_original);
y_m = mean(y_original);
sigma_p = 0;
for i = 1:n
    sigma_p = sigma_p +(y_original(i) - y_m)^2;
    i = i+1;
end;
sigma = sqrt(sigma_p/(n-1));
sigma_y = sigma/sqrt(n);
ME = z*sigma_y*100;
y_max = y_m+ME;
y_min = y_m-ME;
y_r = [];
x_r = [];

for k = 1:n
    if (y_original(k) >= y_min && y_original(k) <= y_max)
        y_r(end + 1) = y_original(k);
        x_r(end + 1) = x_original(k);
    end
end
one_collum = ones(length(x_r),1);
y = y_r';
x = [one_collum x_r'];
beta = (inv(x' * x))*x'*y;
plot(x_r, y_r, '.');
hold on;
plot(x_r, beta(1)+beta(2)*x_r);
grid on;

 