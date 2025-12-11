function lcn = lazycaterernumber(n)
%LAZYCATERERNUMBER Compute the n-th number of the Lazy Caterer's sequence.
% The Lazy Caterer's sequence, more formally known as the central polygonal
% numbers, describes the maximum number of pieces of a disk (for example,
% a pancake or pizza) that can be made with a given number of straight
% cuts. For instance, three cuts can produce up to seven pieces if the cuts
% do not all meet at a common point.
%
% This sequence can be formalized as the number of cells in an arrangement
% of lines in the plane, and is the two-dimensional analogue of the cake
% numbers in three dimensions. In this implementation, the Lazy Caterer's
% numbers are obtained from the first column of Floyd's triangle.
%
% Syntax:
%   lcn = lazycaterernumber(n)
%
% Inputs:
%   n  - nonnegative integer scalar specifying the number of straight cuts
%        applied to the disk (n >= 0).
%
% Outputs:
%   lcn - n-th Lazy Caterer number: the maximum number of pieces into which
%         the disk can be divided by n straight cuts.
%
% Example:
%   lcn = lazycaterernumber(5)
%   returns:
%
%   lcn =
%       16
%
% See also floydtriangle, cakenumber
%
%   Created by Giuseppe Cardillo
%   giuseppe.cardillo.75@gmail.com
%
% GitHub repository:
% https://github.com/dnafinder/numtriangle
%
% Citation:
% Cardillo G. (2025). lazycaterernumber.m: Lazy Caterer sequence generator
% (part of the numtriangle MATLAB toolbox for number triangles and
% related integer sequences). GitHub repository,
% https://github.com/dnafinder/numtriangle/lazycaterernumber.m

% Input validation
validateattributes(n, {'numeric'}, ...
    {'scalar','real','integer','nonnegative'});

n = double(n);

% Derive the Lazy Caterer's number from the first column of Floyd's triangle
fm = floydtriangle(n);
lcn = fm(end, 1);

