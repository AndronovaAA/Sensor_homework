B = importdata('data_set_23_.txt',',');
B = B';
k = log(1-0.99)/log(1-0.2^3);
thresError = 0.01;

for i=1:k
    randomP = randperm(100);
    p1 = [B(1, randomP(1)), B(2, randomP(1)), B(3, randomP(1))];
    p2 = [B(1, randomP(2)),B(2, randomP(2)), B(3, randomP(2))];
    p3 = [B(1, randomP(3)),B(2, randomP(3)), B(3, randomP(3))];
    inliners = [];
    outliners = [];
    ni = 0;
    no = 0;
    bestInliers = [];
    
    a = (p2(2) - p1(2))*(p3(3) - p1(3)) - (p2(3) - p1(3))*(p3(2) - p1(2));
    b = (p2(3) - p1(3))*(p3(1) - p1(1)) - (p2(1) - p1(1))*(p3(3) - p1(3));
    c = (p2(1) - p1(1))*(p3(2) - p1(2)) - (p2(2)- p1(2))*(p3(1) - p1(1));
    d = -(a*p1(1) + b*p1(2) + c*p1(3));
    plane_lenght = sqrt(a*a + b*b + c*c);
    totalError = 0;
    for p = 1:100
        point = B(:,p);
        error = abs (a*point(1) + b*point(2) + c*point(3) + d)/plane_lenght;
        if (thresError >= error)
            inliners(:, ni+1) = point;
            ni = ni+1;
        else
            totalError = totalError + error;
            outliners(:, no+1) = point;
            no = no +1;
        end
    end
    if ni > length(bestInliers)
        bestModel = [a b c d];
        bestInliers = inliners;
        bestError = error;
    end
    
end
plot3(B(1,:),B(2,:),B(3,:),'.');
grid on;
hold on;
[x_grid y_grid] = meshgrid(-10:0.1:10);
surf(x_grid,y_grid, (-bestModel(4)-bestModel(1)*x_grid-bestModel(2)*y_grid)/bestModel(3))