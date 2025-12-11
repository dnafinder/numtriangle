function seam = seatriangle(n)
%SEATRIANGLE Compute the Seidel–Entringer–Arnold (SEA) triangle.
% The Seidel–Entringer–Arnold triangle is a special case of the
% boustrophedon transform, producing the Entringer numbers arranged in
% "ox-plowing" (boustrophedon) order. It can be viewed as a number triangle
% related to alternating permutations and Euler zigzag numbers.
%
% This function returns a lower triangular matrix representation of the SEA
% triangle, with rows indexed from 0 to n (implemented as 1 to n+1 in
% MATLAB). The entries are the Entringer numbers E(n,k) in boustrophedon
% order.
%
% Syntax:
%   seam = seatriangle(n)
%
% Inputs:
%   n  - nonnegative integer scalar specifying the maximum row index of
%        the SEA triangle to be generated. The output matrix has size
%        (n+1)-by-(n+1).
%
% Outputs:
%   seam - (n+1)-by-(n+1) matrix containing the Seidel–Entringer–Arnold
%          triangle. The nonzero entries form a lower triangular pattern,
%          with rows arranged in boustrophedon (zigzag) order.
%
% Example:
%   seam = seatriangle(5)
%   returns:
%
%   seam =
%        1     0     0     0     0     0
%        0     1     0     0     0     0
%        1     1     0     0     0     0
%        0     1     2     2     0     0
%        5     5     4     2     0     0
%        0     5    10    14    16    16
%
% See also entringernumber
%
%   Created by Giuseppe Cardillo
%   giuseppe.cardillo.75@gmail.com
%
% GitHub repository:
% https://github.com/dnafinder/numtriangle
%
% Citation:
% Cardillo G. (2025). seatriangle.m: Seidel–Entringer–Arnold triangle generator
% (part of the numtriangle MATLAB toolbox for number triangles and
% related integer sequences). GitHub repository,
% https://github.com/dnafinder/numtriangle/seatriangle.m

% Input validation
validateattributes(n, {'numeric'}, ...
    {'scalar','real','integer','nonnegative'});

n = double(n);

% For large n, Entringer numbers grow quickly and may exceed the exact
% integer range of double precision.
if n > 20
    warning('seatriangle:LargeN', ...
        ['Entries in the Seidel–Entringer–Arnold triangle grow quickly. ', ...
         'For n > 20, integer values may exceed the exact range of double ', ...
         'precision and results may not be exact.']);
end

if n == 0
    % Minimal SEA triangle: single element
    seam = 1;
elseif n == 1
    % For n == 1, the result is the 2-by-2 identity
    seam = eye(2);
else
    % SEA triangle is usually indexed from 0, but MATLAB indices start
    % at 1, so use N = n + 1 rows and columns.
    N = n + 1;

    % Matrix preallocation
    seam = zeros(N, N);

    % Put 1 in the vertex
    seam(1, 1) = 1;

    % First pass: compute Entringer numbers with the recurrence
    for R = 2:N
        for C = 2:R
            % Entringer recurrence in triangular form:
            % E(R-1, C-1) = E(R-1, C-2) + E(R-2, R-C+1)
            seam(R, C) = seam(R, C-1) + seam(R-1, R-C+1);
        end
    end

    % Second pass: flip odd-indexed rows (3,5,7,...) to obtain the
    % boustrophedon (ox-plowing) ordering.
    for R = 3:2:N
        seam(R, 1:R) = fliplr(seam(R, 1:R));
    end
end

