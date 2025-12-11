function pm = pascaltriangle(n)
%PASCALTRIANGLE Compute a lower triangular matrix form of Pascal's triangle.
% The rows of Pascal's triangle are conventionally enumerated starting with
% row n = 0 at the top (the 0th row). The entries in each row are numbered
% from the left beginning with k = 0 and are usually staggered relative to
% the numbers in the adjacent rows. The triangle may be constructed in the
% following manner: in row 0 (the topmost row), there is a unique nonzero
% entry 1. Each entry of each subsequent row is constructed by adding the
% number above and to the left with the number above and to the right,
% treating blank entries as 0.
%
% This function returns a lower triangular matrix representation of Pascal's
% triangle, with rows indexed from 0 to n (implemented as 1 to n+1 in
% MATLAB), and zeros to the right of the triangle.
%
% Syntax:
%   pm = pascaltriangle(n)
%
% Inputs:
%   n  - nonnegative integer scalar specifying the maximum row index
%        of Pascal's triangle to be generated. The output matrix has
%        size (n+1)-by-(n+1).
%
% Outputs:
%   pm - (n+1)-by-(n+1) lower triangular matrix containing the entries
%        of Pascal's triangle. Elements to the right of the triangle
%        are set to zero.
%
% Example:
%   pm = pascaltriangle(5)
%   returns:
%
%   pm =
%        1     0     0     0     0     0
%        1     1     0     0     0     0
%        1     2     1     0     0     0
%        1     3     3     1     0     0
%        1     4     6     4     1     0
%        1     5    10    10     5     1
%
% See also bernoullitriangle, leibniztriangle, lozanictriangle, ...
%          mosernumber, rascaltriangle, sierpinskitriangle
%
%   Created by Giuseppe Cardillo
%   giuseppe.cardillo.75@gmail.com
%
% GitHub repository:
% https://github.com/dnafinder/numtriangle
%
% Citation:
% Cardillo G. (2025). pascaltriangle.m: Pascal triangle generator
% (part of the numtriangle MATLAB toolbox for number triangles and
% related integer sequences). GitHub repository,
% https://github.com/dnafinder/numtriangle/pascaltriangle.m

% Input validation
validateattributes(n, {'numeric'}, ...
    {'scalar','real','integer','nonnegative'});

n = double(n);

% Warn the user about potential loss of integer accuracy for large n
if n > 50
    warning('pascaltriangle:LargeN', ...
        ['Binomial coefficients grow very quickly. For n > 50, integer ', ...
         'values may exceed the exact range of double precision and ', ...
         'results may not be exact.']);
end

% Pascal's triangle is usually indexed from 0, but MATLAB indices start at 1.
N = n + 1;

% If n == 0 the result is a scalar 1
if n == 0
    pm = 1;

% If n == 1 the result is a 2-by-2 lower triangular matrix of 1s
elseif n == 1
    pm = ones(2, 2);
    pm(1, 2) = 0;

% All the other cases
else
    % Preallocate with the identity matrix
    pm = eye(N, N);
    % Put all 1s in the first column
    pm(:, 1) = ones(N, 1);
    % Put natural numbers in the second column
    pm(:, 2) = (0:n)';

    % If n == 2 your work is finished
    if n == 2
        return
    else
        % Put triangular numbers in the third column
        pm(2:end, 3) = pm(1:end-1, 2) .* (pm(1:end-1, 2) + 1) ./ 2;

        % If n == 3 your work is finished
        if n == 3
            return
        else
            % Put tetrahedral numbers in the fourth column
            pm(3:end, 4) = pm(1:end-2, 2) .* (pm(1:end-2, 2) + 1) .* ...
                           (pm(1:end-2, 2) + 2) ./ 6;

            % If n == 4 your work is finished
            if n == 4
                return
            else
                % Put pentatope numbers in the fifth column
                pm(4:end, 5) = pm(1:end-3, 2) .* (pm(1:end-3, 2) + 1) .* ...
                               (pm(1:end-3, 2) + 2) .* (pm(1:end-3, 2) + 3) ./ 24;

                % If n == 5 your work is finished
                if n == 5
                    return
                else
                    % General case for n >= 6
                    for R = 7:N
                        % The row is symmetric, so find the middle point
                        M = ceil(R / 2);

                        % For columns below the middle point, use the
                        % hockey-stick identity to accumulate binomial
                        % coefficients.
                        for J = 6:M
                            pm(R, J) = sum(pm(1:R-1, J-1));
                        end

                        % Then flip and copy the mid-row to exploit symmetry
                        pm(R, M + ~mod(R, 2):R-1) = fliplr(pm(R, 2:M));
                    end
                end
            end
        end
    end
end
