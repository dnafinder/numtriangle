function Cn = cakenumber(n)
%CAKENUMBER Compute the n-th cake number.
% In mathematics, the cake number C_n is the maximum number of regions
% into which a 3-dimensional cube can be partitioned by exactly n planes.
% The name comes from imagining each partition of the cube by a plane as
% a slice made by a knife through a cube-shaped cake. The two-dimensional
% analogue of these numbers are the Lazy Caterer's numbers.
%
% In the context of number triangles, the n-th cake number can be obtained
% as the sum of the entries in the last row of Rascal's triangle of order n:
%
%   C_n = sum_{k=0}^{n} R(n,k),
%
% where R(n,k) denotes the entries of Rascal's triangle.
%
% Syntax:
%   Cn = cakenumber(n)
%
% Inputs:
%   n  - nonnegative integer scalar specifying the number of planes
%        partitioning the cube (n >= 0).
%
% Outputs:
%   Cn - n-th cake number: the maximum number of regions into which the
%        cube is divided by the n planes.
%
% Example:
%   Cn = cakenumber(7)
%   returns:
%
%   Cn =
%       64
%
% See also rascaltriangle, lazycaterernumber
%
%   Created by Giuseppe Cardillo
%   giuseppe.cardillo.75@gmail.com
%
% GitHub repository:
% https://github.com/dnafinder/numtriangle
%
% Citation:
% Cardillo G. (2025). cakenumber.m: Cake number sequence generator
% (part of the numtriangle MATLAB toolbox for number triangles and
% related integer sequences). GitHub repository,
% https://github.com/dnafinder/numtriangle/cakenumber.m

% Input validation
validateattributes(n, {'numeric'}, ...
    {'scalar','real','integer','nonnegative'});

n = double(n);

% Sum over each row of Rascal's triangle and take the last value
rt = rascaltriangle(n);
s = sum(rt, 2);
Cn = s(end);

