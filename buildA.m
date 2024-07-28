function [ A,b ] = buildA(M, points)

% Construct matrix A in the LP on T(M)
% Input "points" is a 2xD matrix consisting of D points (x1,x2) in the 
% region ([0, M/2)^2 satisfying x2 > max(1,x1)

% Impose a constraint at lattice points (n1,n2) in (1/M)Z^2 satisfying
% ||(n1,n2)||_inf < 1
% Exploiting symmetry of square, we reduce to lattice points (n1,n2)
% satisfying n2 >= n1


size_w = size(points,2)+1;
num_constraints = (M^2 + M)/2;

A = ones(num_constraints, size_w);
b = zeros(num_constraints, 1);

u = [0, 1];
b(1) = M^2;

i = 2;
while i < num_constraints + 1
    % lattice points on y-axis
    if u(1) == 0
        A(i,1) = 4;
        for j = 2:size_w
            y = points(:, j-1);
            A(i, j) = 2*cos(2*pi*y(1)*u(2)/M) + 2*cos(2*pi*y(2)*u(2)/M);
        end
        u(1) = u(1) + 1;
        i = i + 1;
    % lattice points on diagonal
    elseif u(1) == u(2)
        A(i,1) = 4;
        for j = 2:size_w
            y = points(:, j-1);
            A(i, j) = 2*cos(2*pi*(y(1) + y(2))*u(1)/M) + 2*cos(2*pi*(y(1) - y(2))*u(1)/M);
        end
        u(2) = u(2) + 1;
        u(1) = 0;
        i = i+1;
    % other lattice points
    else
        A(i,1) = 8;
        for j = 2:size_w
            y = points(:, j-1);
            term1 = 2*cos(2*pi*(y(1)*u(1) + y(2)*u(2))/M) + 2*cos(2*pi*(y(1)*u(2)+y(2)*u(1))/M);
            term2 = 2*cos(2*pi*(-y(1)*u(1) + y(2)*u(2))/M) + 2*cos(2*pi*(-y(1)*u(2) + y(2)*u(1))/M);
            A(i,j) = term1 + term2;
        end
        u(1) = u(1) + 1;
        i = i+1;
    end

end

