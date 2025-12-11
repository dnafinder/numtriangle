function Cn = catalannumber(n)
%CATALANNUMBER Compute the n-th Catalan number.
% In combinatorial mathematics, the Catalan numbers form a sequence of
% natural numbers that arise in various counting problems, often involving
% recursively defined objects or constrained lattice paths. They are named
% after the French-Belgian mathematician Eugène Charles Catalan.
%
% This function computes the n-th Catalan number C_n by extracting the
% rightmost nonzero entry from the last row of Catalan's triangle.
%
% Syntax:
%   Cn = catalannumber(n)
%
% Inputs:
%   n  - nonnegative integer scalar specifying the index of the Catalan
%        number to be computed.
%
% Outputs:
%   Cn - n-th Catalan number (double).
%
% Example:
%   Cn = catalannumber(7)
%   returns:
%
%   Cn =
%       429
%
% See also catalantriangle
%
%   Created by Giuseppe Cardillo
%   giuseppe.cardillo.75@gmail.com
%
% GitHub repository:
% https://github.com/dnafinder/numtriangle
%
% Citation:
% Cardillo G. (2025). catalannumber.m: Catalan number generator
% (part of the numtriangle MATLAB toolbox for number triangles and
% related integer sequences). GitHub repository,
% https://github.com/dnafinder/numtriangle/catalannumber.m

% Input validation
validateattributes(n, {'numeric'}, ...
    {'scalar','real','integer','nonnegative'});

n = double(n);

% For large n, Catalan numbers grow quickly and may exceed the exact
% integer range of double precision.
if n > 30
    warning('catalannumber:LargeN', ...
        ['Catalan numbers grow quickly. For n > 30, integer values may ', ...
         'exceed the exact range of double precision and results may ', ...
         'not be exact.']);
end

% Build Catalan's triangle and extract the n-th Catalan number from the
% last row, rightmost nonzero entry.
cm = catalantriangle(n);
Cn = cm(end, end);
