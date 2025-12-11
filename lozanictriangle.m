function lm = lozanictriangle(n)
%LOZANICTRIANGLE Compute Lozanić's (Losanitsch's) triangle matrix.
% Lozanić’s triangle (also referred to as Losanitsch’s triangle) is a
% number triangle similar to Pascal’s triangle where three terms out of
% four are the sum of the two numbers immediately above, and one term out
% of four is modified by subtracting a binomial coefficient from the
% corresponding position of Pascal’s triangle.
%
% Numbering rows by n = 0,1,2,... and entries in each row by k = 0,1,2,...,
% the construction is:
%   - Start from the Pascal triangle rule:
%       L(n,k) = L(n-1,k) + L(n-1,k-1)
%   - For even n and odd k (0-based indices), subtract:
%       C(n/2 - 1, (k - 1)/2)
%     i.e., the binomial coefficient at row n/2 - 1, column (k - 1)/2 of
%     Pascal's triangle.
%
% This triangle is named after the Serbian chemist Sima Lozanić (Germanized
% as Losanitsch), and has applications in chemistry, graph theory, and
% combinatorics.
%
% Syntax:
%   lm = lozanictriangle(n)
%
% Inputs:
%   n  - nonnegative integer scalar specifying the maximum row index of
%        Lozanić's triangle to be generated. The output matrix has size
%        (n+1)-by-(n+1).
%
% Outputs:
%   lm - (n+1)-by-(n+1) lower triangular matrix containing Lozanić's
%        triangle. Elements to the right of the triangle are set to zero.
%
% Example:
%   lm = lozanictriangle(7)
%   returns:
%
%   lm =
%        1     0     0     0     0     0     0     0
%        1     1     0     0     0     0     0     0
%        1     1     1     0     0     0     0     0
%        1     2     2     1     0     0     0     0
%        1     2     4     2     1     0     0     0
%        1     3     6     6     3     1     0     0
%        1     3     9    10     9     3     1     0
%        1     4    12    19    19    12     4     1
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
% Cardillo G. (2025). lozanictriangle.m: Lozanić triangle generator
% (part of the numtriangle MATLAB toolbox for number triangles and
% related integer sequences). GitHub repository,
% https://github.com/dnafinder/numtriangle/lozanictriangle.m

% Input validation
validateattributes(n, {'numeric'}, ...
    {'scalar','real','integer','nonnegative'});

n = double(n);

% For large n, entries may exceed the exact integer range of double.
if n > 50
    warning('lozanictriangle:LargeN', ...
        ['Entries in Lozanic''s triangle can grow quickly. For n > 50, ', ...
         'integer values may exceed the exact range of double precision ', ...
         'and results may not be exact.']);
end

% Handle small cases explicitly
if n == 0
    % For n == 0, the result is a scalar 1
    lm = 1;
elseif n == 1
    % For n == 1, the result is a 2-by-2 lower triangular matrix of ones
    lm = ones(2, 2);
    lm(1, 2) = 0;
elseif n == 2
    % For n == 2, the result is a 3-by-3 lower triangular matrix of ones
    lm = tril(ones(3, 3));
else
    % General case n >= 3
    % Get Pascal's triangle up to row n
    pm = pascaltriangle(n);

    % Initialize Lozanic's triangle:
    % - identity as base
    % - first column all ones
    % - set L(2,1) = 1 (third row, second column in MATLAB indexing)
    lm = eye(n + 1, n + 1);
    lm(:, 1) = ones(n + 1, 1);
    lm(3, 2) = 1;

    for row = 3:n
        % The row is symmetric, so find the midpoint (0-based row index = row)
        M = ceil((row + 1) / 2);

        % Compute entries up to the midpoint using the modified Pascal rule
        for k = 1:M-1
            % Sum of the two entries above (Pascal-like)
            lm(row + 1, k + 1) = lm(row, k + 1) + lm(row, k);

            % For odd k and even row (0-based indices), subtract the
            % corresponding binomial coefficient from Pascal's triangle.
            % Here row and k are 0-based in the definition, but 1-based
            % for indexing in MATLAB.
            if mod(k, 2) == 1 && mod(row, 2) == 0
                % pm(row/2, (k-1)/2 + 1) corresponds to C(row/2 - 1, (k-1)/2)
                lm(row + 1, k + 1) = lm(row + 1, k + 1) - ...
                    pm((row / 2 - 1) + 1, (k - 1) / 2 + 1);
            end
        end

        % Exploit symmetry to fill the right-hand side of the row
        lm(row + 1, M + ~mod(row + 1, 2):row) = fliplr(lm(row + 1, 2:M));
    end
end

