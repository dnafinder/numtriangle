function A = euleriannumber(n, k)
%EULERIANNUMBER Compute the Eulerian number <n,k>.
% The Eulerian numbers <n,k> count the number of permutations of
% {1,2,...,n} with exactly k ascents (positions i such that a(i) < a(i+1)).
% They form the Eulerian (or Euler) triangle, closely related to
% combinatorial structures and permutation statistics.
%
% This function returns the Eulerian number <n,k> using:
%   - explicit base cases for n = 0 and n = 1, and
%   - the precomputed Eulerian triangle from EULERTRIANGLE for n >= 2.
%
% Syntax:
%   A = euleriannumber(n, k)
%
% Inputs:
%   n  - nonnegative integer scalar specifying the order (row index).
%   k  - nonnegative integer scalar specifying the ascent index, with
%        0 <= k <= n.
%
% Outputs:
%   A  - Eulerian number <n,k>.
%
% Example:
%   A = euleriannumber(5, 2)
%   returns:
%
%   A =
%        66
%
%   which matches the Eulerian triangle row:
%   <5,0..4> = [1 26 66 26 1].
%
% See also eulertriangle
%
%   Created by Giuseppe Cardillo
%   giuseppe.cardillo.75@gmail.com
%
% GitHub repository:
% https://github.com/dnafinder/numtriangle
%
% Citation:
% Cardillo G. (2025). euleriannumber.m: Eulerian number generator
% (part of the numtriangle MATLAB toolbox for number triangles and
% related integer sequences). GitHub repository,
% https://github.com/dnafinder/numtriangle/euleriannumber.m

% Input validation
validateattributes(n, {'numeric'}, ...
    {'scalar','real','integer','nonnegative'});
validateattributes(k, {'numeric'}, ...
    {'scalar','real','integer','nonnegative'});

n = double(n);
k = double(k);

if k > n
    error('euleriannumber:KTooLarge', ...
        'k must be less than or equal to n.');
end

% For large n, Eulerian numbers grow quickly and may exceed the exact
% integer range of double precision.
if n > 20
    warning('euleriannumber:LargeN', ...
        ['Eulerian numbers grow quickly. For n > 20, integer values may ', ...
         'exceed the exact range of double precision and results may ', ...
         'not be exact.']);
end

% Base cases (consistent with standard Eulerian numbers <n,k>)
if n == 0
    % <0,0> = 1; all other k are zero
    if k == 0
        A = 1;
    else
        A = 0;
    end
    return
elseif n == 1
    % Standard convention: <1,0> = 1, <1,1> = 0
    if k == 0
        A = 1;
    else
        A = 0;
    end
    return
end

% For n >= 2, use the Eulerian triangle.
% eulertriangle(m) (your implementation) returns rows corresponding to
% Eulerian orders up to m+1. To get row n, we call eulertriangle(n-1)
% and read row index n, column index k+1.
em = eulertriangle(n - 1);

% Extract Eulerian number <n,k> from row n, column k+1
A = em(n, k + 1);
