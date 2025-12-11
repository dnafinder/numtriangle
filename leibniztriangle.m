function [D, lm] = leibniztriangle(n)
%LEIBNIZTRIANGLE Compute Leibniz harmonic triangle matrices.
% The Leibniz harmonic triangle is a triangular arrangement of unit
% fractions in which the outermost diagonals consist of the reciprocals of
% the row numbers and each inner cell is given by the cell diagonally above
% and to the left minus the cell to the left. It is closely related to
% Pascal's triangle. The numerators are all 1s, while the denominators form
% the integer triangle listed as sequence A003506 in the OEIS.
%
% This function returns:
%   - D  : the lower triangular matrix of denominators;
%   - lm : the corresponding lower triangular matrix of unit fractions.
%
% Syntax:
%   [D, lm] = leibniztriangle(n)
%
% Inputs:
%   n  - nonnegative integer scalar specifying the maximum row index of
%        the Leibniz harmonic triangle to be generated. The output
%        matrices have size (n+1)-by-(n+1).
%
% Outputs:
%   D  - (n+1)-by-(n+1) lower triangular matrix of denominators.
%   lm - (n+1)-by-(n+1) lower triangular matrix of unit fractions, where
%        lm = tril(1 ./ D).
%
% Example:
%   [D, lm] = leibniztriangle(8)
%   returns, for D:
%
%   D =
%        1     0     0     0     0     0     0     0     0
%        2     2     0     0     0     0     0     0     0
%        3     6     3     0     0     0     0     0     0
%        4    12    12     4     0     0     0     0     0
%        5    20    30    20     5     0     0     0     0
%        6    30    60    60    30     6     0     0     0
%        7    42   105   140   105    42     7     0     0
%        8    56   168   280   280   168    56     8     0
%        9    72   252   504   630   504   252    72     9
%
% and, for lm:
%
%   lm =
%        1.0000         0         0         0         0         0         0         0         0
%        0.5000    0.5000         0         0         0         0         0         0         0
%        0.3333    0.1667    0.3333         0         0         0         0         0         0
%        0.2500    0.0833    0.0833    0.2500         0         0         0         0         0
%        0.2000    0.0500    0.0333    0.0500    0.2000         0         0         0         0
%        0.1667    0.0333    0.0167    0.0167    0.0333    0.1667         0         0         0
%        0.1429    0.0238    0.0095    0.0071    0.0095    0.0238    0.1429         0         0
%        0.1250    0.0179    0.0060    0.0036    0.0036    0.0060    0.0179    0.1250         0
%        0.1111    0.0139    0.0040    0.0020    0.0016    0.0020    0.0040    0.0139    0.1111
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
% Cardillo G. (2025). leibniztriangle.m: Leibniz harmonic triangle generator
% (part of the numtriangle MATLAB toolbox for number triangles and
% related integer sequences). GitHub repository,
% https://github.com/dnafinder/numtriangle/leibniztriangle.m

% Input validation
validateattributes(n, {'numeric'}, ...
    {'scalar','real','integer','nonnegative'});

n = double(n);

% For large n, denominators can grow quickly and may exceed the exact
% integer range of double precision.
if n > 50
    warning('leibniztriangle:LargeN', ...
        ['Entries in the Leibniz harmonic triangle grow quickly. For n > 50, ', ...
         'integer values may exceed the exact range of double precision ', ...
         'and results may not be exact.']);
end

% Build the denominator matrix:
% D(i,j) = i * Pascal(i,j)  (with 1-based indexing in MATLAB)
P = pascaltriangle(n);
rowIdx = (1:n+1)';                 % column vector of row indices
D = P .* repmat(rowIdx, 1, n+1);   % scale each row by its index

% Build the Leibniz harmonic matrix, avoiding division by zero warnings
lm = zeros(size(D));
mask = (D ~= 0);
lm(mask) = 1 ./ D(mask);
lm = tril(lm);
