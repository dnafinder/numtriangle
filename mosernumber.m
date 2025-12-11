function mn = mosernumber(n)
%MOSERNUMBER Compute the n-th Moser number.
% In geometry, Moser's circle problem asks for the maximum number of
% regions into which a circle is divided by chords joining n points on
% the circumference, with no three chords intersecting at an interior
% point and no two chords sharing an endpoint except at the n points.
%
% The resulting sequence M(n) is known as the Moser numbers. An
% equivalent characterization is that M(n) can be obtained as the sum
% of up to the first five terms of the (n-1)-th row of Pascal's
% triangle:
%
%   M(n) = sum_{k=0}^{min(4, n-1)} C(n-1, k).
%
% Syntax:
%   mn = mosernumber(n)
%
% Inputs:
%   n  - positive integer scalar representing the number of points
%        on the circle connected by chords (n >= 1).
%
% Outputs:
%   mn - Moser number: the maximum number of regions into which the
%        circle is divided by the n*(n-1)/2 chords connecting the n
%        points.
%
% Example:
%   mn = mosernumber(6)
%   returns:
%
%   mn =
%       31
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
% Cardillo G. (2025). mosernumber.m: Moser circle problem sequence generator
% (part of the numtriangle MATLAB toolbox for number triangles and
% related integer sequences). GitHub repository,
% https://github.com/dnafinder/numtriangle/mosernumber.m

% Input validation
validateattributes(n, {'numeric'}, ...
    {'scalar','real','integer','>=',1});

n = double(n);

% Build the (n-1)-th order Pascal triangle and sum up to the first
% five entries in the last row (or fewer if n < 5).
P = pascaltriangle(n - 1);
sp = sum(P(:, 1:min(5, n)), 2);
mn = sp(end);

