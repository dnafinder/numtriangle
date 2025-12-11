function [D,lm]=LeibnizTriangle(n)
%LEIBNIZTRIANGLE - Draw a lower triangular matrix form of Leibniz Harmonic Matrix
%The Leibniz harmonic triangle is a triangular arrangement of unit
%fractions in which the outermost diagonals consist of the reciprocals of
%the row numbers and each inner cell is the cell diagonally above and to
%the left minus the cell to the left. It's strictly correlated to Pascal's Triangle.
%The numerators are all 1s, while the denominators are listed in (sequence
%A003506 in the OEIS).
%
%Syntax: 	LeibnizTriangle(n)
%     
%    Inputs:
%          n - integer, non negative number
%    Outputs:
%          D - Triangular Matrix of Denominators
%          lm - Leibniz Matrix
%
%     Example: 
%     [D, lm]=LeibnizTriangle(8) will show 
%
% D =
% 
%      1     0     0     0     0     0     0     0     0
%      2     2     0     0     0     0     0     0     0
%      3     6     3     0     0     0     0     0     0
%      4    12    12     4     0     0     0     0     0
%      5    20    30    20     5     0     0     0     0
%      6    30    60    60    30     6     0     0     0
%      7    42   105   140   105    42     7     0     0
%      8    56   168   280   280   168    56     8     0
%      9    72   252   504   630   504   252    72     9
% 
% 
% lm =
% 
%     1.0000         0         0         0         0         0         0         0         0
%     0.5000    0.5000         0         0         0         0         0         0         0
%     0.3333    0.1667    0.3333         0         0         0         0         0         0
%     0.2500    0.0833    0.0833    0.2500         0         0         0         0         0
%     0.2000    0.0500    0.0333    0.0500    0.2000         0         0         0         0
%     0.1667    0.0333    0.0167    0.0167    0.0333    0.1667         0         0         0
%     0.1429    0.0238    0.0095    0.0071    0.0095    0.0238    0.1429         0         0
%     0.1250    0.0179    0.0060    0.0036    0.0036    0.0060    0.0179    0.1250         0
%     0.1111    0.0139    0.0040    0.0020    0.0016    0.0020    0.0040    0.0139    0.1111
%
%See also PascalTriangle
%
%           Created by Giuseppe Cardillo
%           giuseppe.cardillo.75@gmail.com
%
% To cite this file, this would be an appropriate format:
% Cardillo G. (2024) LeibnizTriangle
% http://www.mathworks.com/matlabcentral/fileexchange

validateattributes(n, {'numeric'}, {'integer', 'nonnegative'});
%Pascal's Triangle starts from 0 but MatLab first index is 1, so...
D=PascalTriangle(n).*repmat((1:1:n+1)',1,n+1);
lm=tril(1./D); 
