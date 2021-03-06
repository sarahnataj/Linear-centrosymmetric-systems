function [error, A]=error_PseudoSpectral1D(n,order)
% Calculate 1D second/fourth order spectral differentiation (pseudospectral) matrices
% Input: n is the number of interior collocation nodes, 
%        order=2 for 1D second order spectral differentiation matrix,
%        order=4 for 1D fourth order spectral differentiation matrix.
% Output: error=\|u-u_ex\|_{\infty}, uex is the exact solution of the 1D 
%         Poisson/biharmonic equations at the collocation points, u is 
%         the approximated solution.
%         A is the second/fourth order spectral differentiation matrices, and
%         
% Author: Sarah Nataj, email:sarah.nataj@gmail.com
method=2; % 1=Legendre  2=Cheb
[D, node]=PSDirv(n,method);
if  order==2
    %SECOND ORDER
    A=D*D;
    A=A(2:n,2:n);
    uex=sin(pi*node(2:n)); 
    f=-pi^2*sin(pi*node(2:n)); 
    error=norm(uex-A\f, inf);
elseif order==4
    %FOURTH ORDER
    B2=(diag(1-node.^2)*D^2-8*diag(node)*D-12*eye(n+1))*D^2*diag([0; 1./(1-node(2:n).^2); 0]);
    A=B2(2:n,2:n);
    uex=1+cos(pi*node(2:n));
    f=pi^4*cos(pi*node(2:n)); 
    error=norm(uex-A\f, inf);
end
%plot(node(2:n),uex,'-',node(2:n),A\f,'--'); %
end
