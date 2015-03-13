syms x y
% symbol expression of fucntion
% must be same as 'f'
f = sin(1/2 * x^2 + 1/4 * y^2 + 3) * cos(2*x + 1 + exp(y)); 
% digital expression of function
f2v1 = @(p) double( subs(f,[x y],p) );
f2v2 = @(a,b) double( subs(f,{x y},{a,b}) );
% gradien in symbolic expression:
g = [diff(f,'x'); diff(f,'y')];
% gradien in digital expression(vector) 
gd = @(p) double( subs(g,[x y], p) );
% length of gradient
f2gl = @(p) norm( gd(p) );
% normalized gradient
f2go = @(p) gd(p)/f2gl(p);


