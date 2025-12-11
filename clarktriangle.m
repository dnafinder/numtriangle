function cm = clarktriangle(n, f)
%CLARKTRIANGLE Compute Clark's triangle matrix.
% Clark's triangle is a number triangle created by setting the vertex equal
% to 0, filling the first column with 1s, the main diagonal with multiples
% of a fixed integer f, and filling the remaining entries by summing the
% elements on either side from one row above (Pascal-type rule).
%
% More precisely, for row index R (1-based, with R = 1 corresponding to
% level 0) and column index C:
%   - cm(1,1) = 0
%   - cm(R,1) = 1 for R >= 2
%   - cm(R,R) = (R-1)*f  (main diagonal)
%   - cm(R,C) = cm(R-1,C) + cm(R-1,C-1) for 3 <= R <= n+1 and 2 <= C <= R-1
%
% Syntax:
%   cm = clarktriangle(n, f)
%
% Inputs:
%   n  - nonnegative integer scalar specifying the maximum row index of
%        Clark's triangle (the output has n+1 rows).
%   f  - nonnegative integer scalar specifying the multiplier used on the
%        main diagonal.
%
% Outputs:
%   cm - (n+1)-by-(n+1) lower triangular matrix containing Clark's
%        triangle. Elements to the right of the triangle are set to zero.
%
% Example:
%   cm = clarktriangle(6, 6)
%   returns:
%
%   cm =
%        0     0     0     0     0     0     0
%        1     6     0     0     0     0     0
%        1     7    12     0     0     0     0
%        1     8    19    18     0     0     0
%        1     9    27    37    24     0     0
%        1    10    36    64    61    30     0
%        1    11    46   100   125    91    36
%
%   Created by Giuseppe Cardillo
%   giuseppe.cardillo.75@gmail.com
%
% GitHub repository:
% https://github.com/dnafinder/numtriangle
%
% Citation:
% Cardillo G. (2025). clarktriangle.m: Clark triangle generator
% (part of the numtriangle MATLAB toolbox for number triangles and
% related integer sequences). GitHub repository,
% https://github.com/dnafinder/numtriangle/clarktriangle.m

% Input validation
validateattributes(n, {'numeric'}, ...
    {'scalar','real','integer','nonnegative'});
validateattributes(f, {'numeric'}, ...
    {'scalar','real','integer','nonnegative'});

n = double(n);
f = double(f);

% For large n, entries may grow combinatorially and exceed exact integer
% range of double precision.
if n > 50
    warning('clarktriangle:LargeN', ...
        ['Entries in Clark''s triangle grow quickly. For n > 50, ', ...
         'integer values may exceed the exact range of double precision ', ...
         'and results may not be exact.']);
end

% Matrix preallocation: diagonal with multiples of f
cm = diag((0:n) .* f);

% Put all ones in the first column except the vertex
if n >= 1
    cm(2:end, 1) = 1;
end

% Fill interior using a Pascal-type rule
for R = 3:n+1
    for C = 2:R-1
        cm(R, C) = cm(R-1, C) + cm(R-1, C-1);
    end
end
