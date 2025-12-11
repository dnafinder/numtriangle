function bm = bernoullitriangle(n)
%BERNOULLITRIANGLE Compute Bernoulli's triangle matrix.
% Bernoulli's triangle is a triangular matrix of partial sums of the
% binomial coefficients, or, equivalently, the cumulative row-wise sum
% of Pascal's triangle. If P is the Pascal triangle matrix, then
% Bernoulli's triangle B is given by
%
%   B(i,j) = sum_{k=0}^j P(i,k),   for j <= i,
%
% with zeros to the right of the triangle.
%
% Syntax:
%   bm = bernoullitriangle(n)
%
% Inputs:
%   n  - nonnegative integer scalar specifying the maximum row index
%        of Bernoulli's triangle to be generated. The output matrix
%        has size (n+1)-by-(n+1).
%
% Outputs:
%   bm - (n+1)-by-(n+1) Bernoulli triangle matrix. Each row contains
%        the cumulative sums of the corresponding row in Pascal's
%        triangle. Elements above the main diagonal are set to zero.
%
% Example:
%   bm = bernoullitriangle(5)
%   returns:
%
%   bm =
%        1     0     0     0     0     0
%        1     2     0     0     0     0
%        1     3     4     0     0     0
%        1     4     7     8     0     0
%        1     5    11    15    16     0
%        1     6    16    26    31    32
%
% See also pascaltriangle
%
%   Created by Giuseppe Cardillo
%   giuseppe.cardillo.75@gmail.com
%
% GitHub repository:
% https://github.com/dnafinder/numtriangle
%
% Citation:
% Cardillo G. (2025). bernoullitriangle.m: Bernoulli triangle generator
% (part of the numtriangle MATLAB toolbox for number triangles and
% related integer sequences). GitHub repository,
% https://github.com/dnafinder/numtriangle/bernoullitriangle.m

% Input validation
validateattributes(n, {'numeric'}, ...
    {'scalar','real','integer','nonnegative'});

n = double(n);

% Warn the user about potential loss of integer accuracy for large n
if n > 50
    warning('bernoullitriangle:LargeN', ...
        ['Entries in Bernoulli''s triangle grow very quickly. For n > 50, ', ...
         'integer values may exceed the exact range of double precision ', ...
         'and results may not be exact.']);
end

% Bernoulli's triangle is obtained as the row-wise cumulative sum of
% Pascal's triangle, restricted to the lower triangular part.
bm = tril(cumsum(pascaltriangle(n), 2));

