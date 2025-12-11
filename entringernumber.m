function en = entringernumber(n, k)
%ENTRINGERNUMBER Compute the Entringer number E(n,k).
% The Entringer numbers E(n,k) (OEIS A008281) count the number of
% permutations of {1,2,...,n+1}, starting with k+1, which, after
% initially falling, alternately fall then rise. A suitably arranged
% number triangle of these numbers is known as the Seidel–Entringer–
% Arnold (SEA) triangle.
%
% This function computes E(n,k) by extracting the appropriate entry from
% the SEA triangle of order n, converted back from boustrophedon (zigzag)
% ordering to the standard Entringer layout.
%
% Syntax:
%   en = entringernumber(n, k)
%
% Inputs:
%   n  - nonnegative integer scalar specifying the row index.
%   k  - nonnegative integer scalar specifying the column index, with
%        0 <= k <= n.
%
% Outputs:
%   en - Entringer number E(n,k).
%
% Example:
%   en = entringernumber(4, 3)
%   returns:
%
%   en =
%        5
%
% See also seatriangle
%
%   Created by Giuseppe Cardillo
%   giuseppe.cardillo.75@gmail.com
%
% GitHub repository:
% https://github.com/dnafinder/numtriangle
%
% Citation:
% Cardillo G. (2025). entringernumber.m: Entringer number generator
% (part of the numtriangle MATLAB toolbox for number triangles and
% related integer sequences). GitHub repository,
% https://github.com/dnafinder/numtriangle/entringernumber.m

% Input validation
validateattributes(n, {'numeric'}, ...
    {'scalar','real','integer','nonnegative'});
validateattributes(k, {'numeric'}, ...
    {'scalar','real','integer','nonnegative'});

n = double(n);
k = double(k);

if k > n
    error('entringernumber:KTooLarge', ...
        'k must be less than or equal to n.');
end

% Build the SEA triangle of order n (boustrophedon ordering)
seam = seatriangle(n);

% Convert back to the standard Entringer layout by flipping odd-indexed
% rows (3,5,7,...) once more. This undoes the boustrophedon ordering.
for R = 3:2:(n + 1)
    seam(R, 1:R) = fliplr(seam(R, 1:R));
end

% Extract E(n,k) from row n+1, column k+1
en = seam(n + 1, k + 1);

