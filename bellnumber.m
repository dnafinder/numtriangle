function Bn = bellnumber(n)
%BELLNUMBER Compute the n-th Bell number.
% In combinatorial mathematics, the Bell numbers count the possible
% partitions of a set. They are named after Eric Temple Bell, who wrote
% about them in the 1930s. The n-th Bell number counts the number of
% different ways to partition a set that has exactly n elements, or
% equivalently, the number of equivalence relations on that set.
%
% Syntax:
%   Bn = bellnumber(n)
%
% Inputs:
%   n  - nonnegative integer scalar specifying the index of the Bell
%        number to be computed.
%
% Outputs:
%   Bn - n-th Bell number.
%
% Example:
%   Bn = bellnumber(7)
%   returns:
%
%   Bn =
%      877
%
% See also belltriangle
%
%   Created by Giuseppe Cardillo
%   giuseppe.cardillo.75@gmail.com
%
% GitHub repository:
% https://github.com/dnafinder/numtriangle
%
% Citation:
% Cardillo G. (2025). bellnumber.m: Bell number generator
% (part of the numtriangle MATLAB toolbox for number triangles and
% related integer sequences). GitHub repository,
% https://github.com/dnafinder/numtriangle/bellnumber.m

% Input validation
validateattributes(n, {'numeric'}, ...
    {'scalar','real','integer','nonnegative'});

n = double(n);

% The Bell number B_n is the first element of the last row
% of the Bell triangle of order n.
bm = belltriangle(n);
Bn = bm(end, 1);
