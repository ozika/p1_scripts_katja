function [M_out] = meanD(M_in,D,argin)
%takes the mean over the dimensions in D
if nargin<2||isempty(D),M_out=mean(M_in);return;end
if nargin<3||isempty(argin),argin='default';end
if length(unique(D))~=length(D),error('double dimensions');end
S = size(M_in);
N = prod(S(D));
if D(end)>length(S),error('dimension does not exist');end
if length(D)==length(S),M_out=mean(M_in(:),argin);end
dims = 1:length(S);
dims = [D,dims(~ismember(dims,D))];
S=S(dims);
M_out = permute(M_in,dims); % move the requested dimensions to the beginning
M_out = reshape(M_out,[N,S(1+length(D):end)]);
M_out = mean(M_out,argin);
s = size(M_in);
s(ismember(1:ndims(M_in), D)) = 1;
M_out = reshape(M_out, s);