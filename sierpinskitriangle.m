function sm = sierpinskitriangle(n)
%SIERPINSKITRIANGLE Compute the Sierpiński triangle from Pascal's triangle.
% The Sierpiński triangle can be obtained by taking Pascal's triangle
% modulo 2. In this representation, entries equal to 1 correspond to the
% "filled" cells of the fractal pattern, while entries equal to 0 correspond
% to "empty" cells.
%
% This function builds the Sierpiński triangle up to row n by computing
% Pascal's triangle and reducing all entries modulo 2.
%
% Syntax:
%   sm = sierpinskitriangle(n)
%
% Inputs:
%   n  - nonnegative integer scalar specifying the maximum row index of
%        Pascal's triangle (and thus of the Sierpiński triangle) to be
%        generated. The output matrix has size (n+1)-by-(n+1).
%
% Outputs:
%   sm - (n+1)-by-(n+1) lower triangular matrix containing the entries of
%        Pascal's triangle modulo 2. Elements to the right of the triangle
%        are zero.
%
% Example:
%   sm = sierpinskitriangle(5)
%   returns:
%
%   sm =
%        1     0     0     0     0     0
%        1     1     0     0     0     0
%        1     0     1     0     0     0
%        1     1     1     1     0     0
%        1     0     0     0     1     0
%        1     1     0     0     1     1
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
% Cardillo G. (2025). sierpinskitriangle.m: Sierpiński triangle generator
% (part of the numtriangle MATLAB toolbox for number triangles and
% related integer sequences). GitHub repository,
% https://github.com/dnafinder/numtriangle/sierpinskitriangle.m

% Input validation
validateattributes(n, {'numeric'}, ...
    {'scalar','real','integer','nonnegative'});

n = double(n);

% For large n, the size of the output grows as (n+1)-by-(n+1) and
% visualization may become expensive.
if n > 2000
    warning('sierpinskitriangle:LargeN', ...
        ['The output matrix size is (n+1)-by-(n+1). For n > 2000, ', ...
         'memory usage and visualization may be significant.']);
end

% Compute Pascal's triangle and reduce modulo 2
sm = mod(pascaltriangle(n), 2);
