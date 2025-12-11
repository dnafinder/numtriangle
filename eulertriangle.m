function em = eulertriangle(n)
%EULERTRIANGLE Compute Euler's number triangle (Eulerian triangle).
% This function returns a lower triangular matrix whose entries are the
% shifted Eulerian numbers <n,k>. The n-th row (0-based indexing) contains
% the Eulerian numbers of order n, and the sum of all elements on the n-th
% row equals n!.
%
% The triangle is usually indexed from n = 0, but here rows are indexed
% from 0 to n and implemented as 1 to n+1 in MATLAB. The triangle is
% symmetric in each row, and this symmetry is exploited to reduce the
% computation.
%
% Syntax:
%   em = eulertriangle(n)
%
% Inputs:
%   n  - nonnegative integer scalar specifying the maximum row index of
%        Euler's triangle to be generated. The output matrix has size
%        (n+1)-by-(n+1).
%
% Outputs:
%   em - (n+1)-by-(n+1) lower triangular matrix containing the shifted
%        Eulerian numbers. Elements to the right of the triangle are set
%        to zero. The sum of row r (0-based) is r!.
%
% Example:
%   em = eulertriangle(5)
%   returns:
%
%   em =
%        1     0     0     0     0     0
%        1     1     0     0     0     0
%        1     4     1     0     0     0
%        1    11    11     1     0     0
%        1    26    66    26     1     0
%        1    57   302   302    57     1
%
%   Created by Giuseppe Cardillo
%   giuseppe.cardillo.75@gmail.com
%
% GitHub repository:
% https://github.com/dnafinder/numtriangle
%
% Citation:
% Cardillo G. (2025). eulertriangle.m: Eulerian triangle generator
% (part of the numtriangle MATLAB toolbox for number triangles and
% related integer sequences). GitHub repository,
% https://github.com/dnafinder/numtriangle/eulertriangle.m

% Input validation
validateattributes(n, {'numeric'}, ...
    {'scalar','real','integer','nonnegative'});

n = double(n);

% For large n, Eulerian numbers grow quickly and may exceed the exact
% integer range of double precision.
if n > 20
    warning('eulertriangle:LargeN', ...
        ['Entries in Euler''s triangle grow quickly. For n > 20, ', ...
         'integer values may exceed the exact range of double precision ', ...
         'and results may not be exact.']);
end

% Euler's triangle is usually indexed from 0, but MATLAB indices start
% at 1, so use N = n + 1 rows and columns.
N = n + 1;

% Handle small cases explicitly
if n == 0
    % Minimal triangle: single entry 1
    em = 1;
elseif n == 1
    % For n == 1, the result is a 2-by-2 lower triangular matrix [1 0; 1 1]
    em = ones(2, 2);
    em(1, 2) = 0;
else
    % Preallocate identity and set first column to ones
    em = eye(N, N);
    em(:, 1) = ones(N, 1);

    % Fill the triangle using an Eulerian-type recurrence and symmetry
    for R = 2:N-1
        % The row R+1 (1-based) corresponds to Eulerian order R (0-based)
        % Each row is symmetric, so compute only up to the midpoint.
        M = ceil((R + 1) / 2);

        % Compute shifted Eulerian numbers up to the midpoint
        for C = 2:M
            em(R+1, C) = C * em(R, C) + (R + 2 - C) * em(R, C-1);
        end

        % Exploit symmetry to fill the right-hand side of the row
        em(R+1, M + ~mod(R+1, 2):R) = fliplr(em(R+1, 2:M));
    end
end
