function tm = trinomialtriangle(n)
%TRINOMIALTRIANGLE Compute the trinomial coefficients triangle.
% The trinomial triangle is a number triangle of trinomial coefficients.
% It can be obtained by starting with a row containing a single 1 and the
% next row containing three 1s, then letting subsequent row elements be
% computed by summing the elements above to the left, directly above, and
% above to the right.
%
% More precisely, if T(n,k) denotes the entry in row n and column k
% (0-based indices), the recurrence is:
%
%   T(0,0) = 1,
%   T(1,0..2) = 1,
%   T(n,k) = T(n-1,k-1) + T(n-1,k) + T(n-1,k+1)  (with out-of-range terms
%                                                treated as zero),
%
% and each row is symmetric.
%
% Syntax:
%   tm = trinomialtriangle(n)
%
% Inputs:
%   n  - nonnegative integer scalar specifying the maximum row index of
%        the trinomial triangle to be generated. The output matrix has
%        size (n+1)-by-(2n+1).
%
% Outputs:
%   tm - (n+1)-by-(2n+1) matrix containing the trinomial triangle. Each
%        row r (0-based) has 2*r+1 nonzero entries centered in the row,
%        with zeros used for padding on the right.
%
% Example:
%   tm = trinomialtriangle(4)
%   returns:
%
%   tm =
%        1     0     0     0     0     0     0     0     0
%        1     1     1     0     0     0     0     0     0
%        1     2     3     2     1     0     0     0     0
%        1     3     6     7     6     3     1     0     0
%        1     4    10    16    19    16    10     4     1
%
%   Created by Giuseppe Cardillo
%   giuseppe.cardillo.75@gmail.com
%
% GitHub repository:
% https://github.com/dnafinder/numtriangle
%
% Citation:
% Cardillo G. (2025). trinomialtriangle.m: Trinomial triangle generator
% (part of the numtriangle MATLAB toolbox for number triangles and
% related integer sequences). GitHub repository,
% https://github.com/dnafinder/numtriangle/trinomialtriangle.m

% Input validation
validateattributes(n, {'numeric'}, ...
    {'scalar','real','integer','nonnegative'});

n = double(n);

% For large n, trinomial coefficients can grow quickly and may exceed the
% exact integer range of double precision.
if n > 20
    warning('trinomialtriangle:LargeN', ...
        ['Trinomial coefficients grow quickly. For n > 20, integer values ', ...
         'may exceed the exact range of double precision and results may ', ...
         'not be exact.']);
end

% Trinomial triangle is usually indexed from 0, but MATLAB indices start
% at 1, so use N = n + 1 rows and 2*n+1 columns.
if n == 0
    % For n == 0, the result is a scalar 1
    tm = 1;
elseif n == 1
    % For n == 1, the result is:
    % row 0: 1
    % row 1: 1 1 1
    tm = ones(2, 3);
    tm(1, 2:3) = 0;
else
    % General case n >= 2
    N = n + 1;
    tm = zeros(N, 2*n + 1);

    % Initialize:
    % - first column to 1s (leftmost nonzero entry in each row)
    % - second column to 0,1,2,...,n (used in the recurrence construction)
    % - set the central pattern for row 1 (n=1) explicitly
    tm(:, 1) = 1;
    tm(:, 2) = (0:n)';
    tm(2, 3) = 1;  % row 1: [1 1 1]

    % Build rows 2..n using the trinomial recurrence and symmetry
    for R = 3:N
        % Number of nonzero columns for row R (0-based row index = R-1)
        cols = 2*(R-1) + 1;
        % Midpoint of the row
        M = ceil(cols/2);

        % Compute entries up to the midpoint
        for C = 3:M
            % Sum the three entries above: left, center, and right
            tm(R, C) = sum(tm(R-1, C-2:C));
        end

        % Exploit symmetry to fill the right-hand side of the row
        tm(R, M+1:cols) = fliplr(tm(R, 1:M-1));
    end
end

