function rm = rascaltriangle(n)
%RASCALTRIANGLE Compute Rascal's triangle matrix.
% Rascal's triangle is similar to Pascal's triangle, but while in Pascal's
% triangle each cell (South) is the sum of the two upper adjacent cells
% (West and East), i.e. South = West + East, in Rascal's triangle there is
% a diamond pattern in which
%
%   South = (West * East + 1) / North
%
% where:
%   - West  = entry immediately above-left,
%   - East  = entry immediately above-right,
%   - North = entry two rows above (same column).
%
% The triangle is symmetric along its vertical axis, and this symmetry is
% exploited to reduce computation.
%
% Syntax:
%   rm = rascaltriangle(n)
%
% Inputs:
%   n  - nonnegative integer scalar specifying the maximum row index of
%        Rascal's triangle to be generated. The output matrix has size
%        (n+1)-by-(n+1).
%
% Outputs:
%   rm - (n+1)-by-(n+1) lower triangular matrix containing the entries of
%        Rascal's triangle. Elements to the right of the triangle are set
%        to zero.
%
% Example:
%   rm = rascaltriangle(5)
%   returns:
%
%   rm =
%        1     0     0     0     0     0
%        1     1     0     0     0     0
%        1     2     1     0     0     0
%        1     3     3     1     0     0
%        1     4     5     4     1     0
%        1     5     7     7     5     1
%
% See also pascaltriangle, cakenumber
%
%   Created by Giuseppe Cardillo
%   giuseppe.cardillo.75@gmail.com
%
% GitHub repository:
% https://github.com/dnafinder/numtriangle
%
% Citation:
% Cardillo G. (2025). rascaltriangle.m: Rascal triangle generator
% (part of the numtriangle MATLAB toolbox for number triangles and
% related integer sequences). GitHub repository,
% https://github.com/dnafinder/numtriangle/rascaltriangle.m

% Input validation
validateattributes(n, {'numeric'}, ...
    {'scalar','real','integer','nonnegative'});

n = double(n);

% For large n, entries can grow quickly and may exceed the exact integer
% range of double precision.
if n > 50
    warning('rascaltriangle:LargeN', ...
        ['Entries in Rascal''s triangle grow quickly. For n > 50, ', ...
         'integer values may exceed the exact range of double precision ', ...
         'and results may not be exact.']);
end

if n <= 3
    % From 0 to 3, Rascal's triangle coincides with Pascal's triangle
    rm = pascaltriangle(n);
else
    % Rascal's triangle is usually indexed from 0, but MATLAB indices
    % start at 1, so use N = n + 1 rows and columns.
    N = n + 1;

    % Preallocate with the identity matrix
    rm = eye(N, N);

    % Put all ones in the first column
    rm(:, 1) = ones(N, 1);

    % Put natural numbers in the second column
    rm(:, 2) = (0:n)';

    % Put odd numbers in the third column (starting from row 3)
    rm(3:end, 3) = rm(2:end-1, 2) .* 2 - 1;

    % General construction using the diamond pattern and symmetry
    for R = 5:N
        % The row is symmetric, so find the middle point
        M = ceil(R / 2);

        % Compute entries from column 4 to the middle using the diamond rule
        for J = 4:M
            % South = (West * East + 1) / North
            rm(R, J) = (rm(R-1, J-1) * rm(R-1, J) + 1) / rm(R-2, J-1);
        end

        % Then flip and copy the mid-row to exploit symmetry
        rm(R, M + ~mod(R, 2):R-1) = fliplr(rm(R, 2:M));
    end
end

