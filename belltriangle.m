function bm = belltriangle(n)
%BELLTRIANGLE Compute Bell's triangle matrix.
% In mathematics, the Bell triangle is a triangle of numbers analogous to
% Pascal's triangle, whose values count partitions of a set in which a
% given element is the largest singleton. It is closely related to the
% Bell numbers, which may be found on both sides of the triangle and are
% in turn named after Eric Temple Bell. The Bell triangle has been
% discovered independently by multiple authors, beginning with Charles
% Sanders Peirce (1880) and including also Alexander Aitken (1933) and
% Cohn et al. (1962); for this reason it is also known as Aitken's array
% or the Peirce triangle.
%
% Syntax:
%   bm = belltriangle(n)
%
% Inputs:
%   n  - nonnegative integer scalar specifying the maximum index of the
%        Bell triangle. The returned matrix has size (n+1)-by-(n+1).
%
% Outputs:
%   bm - (n+1)-by-(n+1) Bell triangle matrix. Entries to the right of the
%        triangle are set to zero.
%
% Example:
%   bm = belltriangle(6)
%   returns:
%
%   bm =
%        1     0     0     0     0     0     0
%        1     2     0     0     0     0     0
%        2     3     5     0     0     0     0
%        5     7    10    15     0     0     0
%       15    20    27    37    52     0     0
%       52    67    87   114   151   203     0
%      203   255   322   409   523   674   877
%
% See also bellnumber
%
%   Created by Giuseppe Cardillo
%   giuseppe.cardillo.75@gmail.com
%
% GitHub repository:
% https://github.com/dnafinder/numtriangle
%
% Citation:
% Cardillo G. (2025). belltriangle.m: Bell triangle generator
% (part of the numtriangle MATLAB toolbox for number triangles and
% related integer sequences). GitHub repository,
% https://github.com/dnafinder/numtriangle/belltriangle.m

% Input validation
validateattributes(n, {'numeric'}, ...
    {'scalar','real','integer','nonnegative'});

n = double(n);

% Warn the user about potential loss of integer accuracy for large n
if n > 25
    warning('belltriangle:LargeN', ...
        ['Bell numbers grow very quickly. For n > 25, integer values may ', ...
         'exceed the exact range of double precision and results may not ', ...
         'be exact.']);
end

% Bell's triangle is usually indexed from 0, but MATLAB indices start at 1.
N = n + 1;

if n == 0
    % Minimal Bell triangle: single element
    bm = 1;
else
    % Preallocate the matrix and set the first element
    bm = zeros(N, N);
    bm(1, 1) = 1;

    % After the initial placement of 1 in the top row, it is the last
    % position in its row and is copied to the leftmost position in the
    % next row. Each subsequent entry is the sum of the entry to its left
    % and the entry above-left. The last entry in each row is then copied
    % to the first column of the next row, and the process continues.
    for I = 2:N
        bm(I, 1) = bm(I-1, I-1);
        for J = 2:I
            bm(I, J) = bm(I, J-1) + bm(I-1, J-1);
        end
    end
end
