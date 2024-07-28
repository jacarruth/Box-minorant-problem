% We solve the linear programming problem on T(M) = R^2/(MZ^2)
% M must be larger than 2
M = 4;


% Initially solve the LP on a lattice (1/N)Z^2 
N = 40;
points = latticePoints(M, N);


[optimal_value,w,A] = solveLP(points, M);
fprintf('optimal value of %i\n', optimal_value);





% Attempt to improve the upper bound by iteratively adding random points
% to the sample

sample_size = 1000;
number_of_iterations = 1000;
current_iteration = 1;
while current_iteration <= number_of_iterations
    new_points = randomPoints(M, sample_size);
    active_indices = find(w);
    points = [points(:, active_indices(2:end) - 1) new_points];
    [optimal_value,w,A] = solveLP(points, M);
    fprintf("Iteration %i of %i\n", current_iteration, number_of_iterations)
    fprintf('Optimal value of %i\n', optimal_value);
    current_iteration = current_iteration + 1;
end


