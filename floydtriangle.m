function fm = floydtriangle(n)
%FLOYDTRIANGLE Compute Floyd's triangle matrix.
% Floyd's triangle is a triangular array of natural numbers used in
% computer science education. It is defined by filling the rows of
% the triangle with consecutive integers, starting with 1 in the top
% left corner and continuing row by row.
%
% This function returns a lower triangular matrix representation of
% Floyd's triangle, with rows indexed from 0 to n (implemented as 1
% to n+1 in MATLAB), and zeros to the right of the triangle.
%
% Syntax:
%   fm = floydtriangle(n)
%
% Inputs:
%   n  - nonnegative integer scalar specifying the maximum row index
%        of Floyd's triangle to be generated. The output matrix has
%        size (n+1)-by-(n+1).
%
% Outputs:
%   fm - (n+1)-by-(n+1) lower triangular matrix containing the entries
%        of Floyd's triangle. Elements to the right of the triangle
%        are set to zero.
%
% Example:
%   fm = floydtriangle(5)
%   returns:
%
%   fm =
%        1     0     0     0     0     0
%        2     3     0     0     0     0
%        4     5     6     0     0     0
%        7     8     9    10     0     0
%       11    12    13    14    15     0
%       16    17    18    19    20    21
%
% See also lazycaterernumber
%
%   Created by Giuseppe Cardillo
%   giuseppe.cardillo.75@gmail.com
%
% GitHub repository:
% https://github.com/dnafinder/numtriangle
%
% Citation:
% Cardillo G. (2025). floydtriangle.m: Floyd triangle generator
% (part of the numtriangle MATLAB toolbox for number triangles and
% related integer sequences). GitHub repository,
% https://github.com/dnafinder/numtriangle/floydtriangle.m

% Input validation
validateattributes(n, {'numeric'}, ...
    {'scalar','real','integer','nonnegative'});

n = double(n);

% Floyd's triangle is usually indexed from 0, but MATLAB indices start
% at 1, so use N = n + 1 rows and columns.
N = n + 1;

% Matrix preallocation: lower triangular part initialized to ones
fm = tril(ones(N, N));

% Vector of natural numbers from 2 to the total number of cells
% in the lower triangular part: N*(N+1)/2
nn = 2:1:(N * (N + 1) / 2);

% Cumulative sums of 1..N: mm(r) = 1 + 2 + ... + r
mm = cumsum(1:1:N);

% Fill rows 2..N with consecutive integers from nn
for R = 2:N
    fm(R, 1:R) = nn(mm(R-1):mm(R)-1);
end

