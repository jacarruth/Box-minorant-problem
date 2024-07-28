function [ boxPoints ] = randomPoints( M, L)

% Returns a 2 x L array consisting of L points (x1, x2) in the region
% ([0, M/2)^2 satisfying x2 > max(1,x1)

if M <=2
    error("parameter M must be larger than 2")
end

boxPoints = zeros(2, L);

kk = 1;
while kk < (L+1)
    candidate = rand(2,1)*(M/2);
    if candidate(2)>max(1,candidate(1))
        boxPoints(:, kk) = candidate;
        kk = kk + 1;
    end
end


end

