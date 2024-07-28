function [ points ] = latticePoints(M, N)


% Generates lattice points (1/N)Z^2 in the region [0,M/2)^2 satisfying x2 >
% max(1,x1)

if M <=2
    error("parameter M must be larger than 2")
end

% Initialize a vector to hold lattice points
points = zeros(2, floor(M*N/2+1));

% Add lattice points to the vector, starting with (0,1)
u = [0 1];
i = 1;
while u(2) <= M/2
    points(:, i) = u;
    i = i + 1;
    if u(1) + 1/N <= u(2)
        u(1) = u(1) + 1/N;
    else
        u(1) = 0;
        u(2) = u(2) + 1/N;
    end
end
points = points(:, 1: i-1);