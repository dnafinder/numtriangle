function Bn = bernoullinumber(n)
%BERNOULLINUMBER Compute the n-th Bernoulli number.
% In mathematics, the Bernoulli numbers B_n are a sequence of rational
% numbers that occur frequently in analysis and number theory. They appear
% in the Taylor series expansions of the tangent and hyperbolic tangent
% functions, in Faulhaber's formula for sums of powers of the first n
% positive integers, in the Euler–Maclaurin formula, and in expressions
% for certain values of the Riemann zeta function.
%
% This implementation uses the convention:
%   B_0 = 1, B_1 = 1/2, and B_n = 0 for odd n > 1.
% For even n >= 2, B_n is computed using a Hessenberg matrix constructed
% from Pascal's triangle.
%
% Syntax:
%   Bn = bernoullinumber(n)
%
% Inputs:
%   n  - nonnegative integer scalar specifying the index of the Bernoulli
%        number to be computed.
%
% Outputs:
%   Bn - n-th Bernoulli number (double), using the convention
%        B_0 = 1, B_1 = 1/2, B_n = 0 for odd n > 1.
%
% Examples:
%   Bn = bernoullinumber(3)
%   returns:
%
%   Bn =
%        0
%
%   Bn = bernoullinumber(4)
%   returns a negative value close to:
%
%   Bn =
%      -0.0333
%
% See also pascaltriangle, bernoullitriangle
%
%   Created by Giuseppe Cardillo
%   giuseppe.cardillo.75@gmail.com
%
% GitHub repository:
% https://github.com/dnafinder/numtriangle
%
% Citation:
% Cardillo G. (2025). bernoullinumber.m: Bernoulli number generator
% (part of the numtriangle MATLAB toolbox for number triangles and
% related integer sequences). GitHub repository,
% https://github.com/dnafinder/numtriangle/bernoullinumber.m

% Input validation
validateattributes(n, {'numeric'}, ...
    {'scalar','real','integer','nonnegative'});

n = double(n);

% For large n, determinant-based computation may suffer from numerical
% inaccuracies in double precision.
if n > 20
    warning('bernoullinumber:LargeN', ...
        ['Determinant-based computation of Bernoulli numbers may suffer ', ...
         'from numerical inaccuracies for n > 20 in double precision.']);
end

% There are formulas connecting Pascal's triangle to Bernoulli numbers:
% B_n = |A_n| / (n+1)!
% where |A_n| is the determinant of an n-by-n lower Hessenberg matrix
% extracted from Pascal's triangle.
%
% Reference (in Italian):
% Pietrocola, Giorgio (October 31, 2008),
% "Esplorando un antico sentiero: teoremi sulla somma di potenze di interi
% successivi (Corollario 2b)", Maecla, retrieved April 8, 2017.
% http://www.maecla.it/Matematica/sommapotenze/teorema_1B.htm#teorema1b

if n == 0
    Bn = 1;
elseif n == 1
    Bn = 1/2;
else
    % All Bernoulli numbers with odd index greater than 1 are zero
    if mod(n, 2) == 1
        Bn = 0;
    else
        % Build Pascal's triangle up to row n+1
        pm = pascaltriangle(n + 1);
        % Extract the n-by-n lower Hessenberg matrix from the bottom part
        Hessenberg = tril(pm(end-n+1:end, 1:n), 1);
        % Use logarithm and gamma function to compute:
        % B_n = det(Hessenberg) / (n+1)!  = exp(log(det(Hess)) - gammaln(n+2))
        detVal = round(det(Hessenberg)); % enforce integer value
        Bn = real(exp(log(detVal) - gammaln(n + 2)));
    end
end

