function [optimal_value, w, A] = solveLP(points, M)

[A,b] = buildA(M, points);
size_w = size(A,2);

cvx_begin quiet
    variable w(size_w,1) nonnegative
    minimize w(1)
    subject to
        A*w == b
cvx_end


optimal_value = cvx_optval;

end

