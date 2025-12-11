function cm = catalantriangle(n)
%CATALANTRIANGLE Compute Catalan's triangle matrix.
% In combinatorial mathematics, Catalan's triangle is a number triangle
% whose entries C(n,k) give the number of strings consisting of n X's and k
% Y's such that no initial segment of the string has more Y's than X's. It
% is a generalization of the Catalan numbers and is named after Eugène
% Charles Catalan.
%
% This function returns a lower triangular matrix representation of
% Catalan's triangle, with rows indexed from 0 to n (implemented as 1 to
% n+1 in MATLAB), and zeros to the right of the triangle.
%
% Syntax:
%   cm = catalantriangle(n)
%
% Inputs:
%   n  - nonnegative integer scalar specifying the maximum row index of
%        Catalan's triangle to be generated. The output matrix has size
%        (n+1)-by-(n+1).
%
% Outputs:
%   cm - (n+1)-by-(n+1) lower triangular matrix containing the entries
%        of Catalan's triangle. Elements to the right of the triangle are
%        set to zero. The rightmost nonzero diagonal contains the Catalan
%        numbers.
%
% Example:
%   cm = catalantriangle(7)
%   returns:
%
%   cm =
%        1     0     0     0     0     0     0     0
%        1     1     0     0     0     0     0     0
%        1     2     2     0     0     0     0     0
%        1     3     5     5     0     0     0     0
%        1     4     9    14    14     0     0     0
%        1     5    14    28    42    42     0     0
%        1     6    20    48    90   132   132     0
%        1     7    27    75   165   297   429   429
%
% See also catalannumber
%
%   Created by Giuseppe Cardillo
%   giuseppe.cardillo.75@gmail.com
%
% GitHub repository:
% https://github.com/dnafinder/numtriangle
%
% Citation:
% Cardillo G. (2025). catalantriangle.m: Catalan triangle generator
% (part of the numtriangle MATLAB toolbox for number triangles and
% related integer sequences). GitHub repository,
% https://github.com/dnafinder/numtriangle/catalantriangle.m

% Input validation
validateattributes(n, {'numeric'}, ...
    {'scalar','real','integer','nonnegative'});

n = double(n);

% For large n, entries in Catalan's triangle grow quickly and may exceed
% the exact integer range of double precision.
if n > 30
    warning('catalantriangle:LargeN', ...
        ['Entries in Catalan''s triangle grow quickly. For n > 30, ', ...
         'integer values may exceed the exact range of double precision ', ...
         'and results may not be exact.']);
end

% Catalan's triangle is usually indexed from 0, but MATLAB indices start
% at 1, so use N = n + 1 rows and columns.
N = n + 1;

if n == 0
    % Minimal Catalan triangle: single element
    cm = 1;
elseif n == 1
    % For n == 1, the result is a 2-by-2 lower triangular matrix of ones
    cm = ones(2, 2);
    cm(1, 2) = 0;
else
    % Preallocate the matrix
    cm = zeros(N, N);
    cm(:, 1) = ones(N, 1);     % first column: all ones
    cm(:, 2) = (0:n)';         % second column: 0,1,2,...,n

    % Fill the triangle
    for J = 3:N
        % The diagonal entry equals the previous entry in the same row
        cm(J, J) = cm(J, J-1);

        % Use a cumulative-row (hockey-stick style) construction below
        for I = J+1:N
            cm(I, J) = sum(cm(I-1, :));
        end
    end
end

