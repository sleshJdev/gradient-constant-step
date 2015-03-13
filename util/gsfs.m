function [ vMin, point, path ] = gsfs( x1, x2, y1, y2, e, ox, oy, s )
%GSFS Gradient Search Fixed Step Function
%   finds the minimum of the function 
%   using the gradient method with constant step
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
    
    precision               = e;      
    sizeOfStep              = s;
    startPoint              = [ox;
                               oy];
    currentPoint            = startPoint;
    path                    = startPoint;
    bounds                  = [x1, x2;  % x definitional domain
                               y1, y2]; % y definitional domain    
    stopper = 1;
    isRunning = true;
    while isRunning    
         stopper = stopper + 1;   
         if stopper == 25
            break;
         end;               
%          gradientLength     = f2gl(currentPoint);
%          if gradientLength <= precision
%              break;
%          end;   
         grad         = f2go(currentPoint);
         nextPoint    = currentPoint - sizeOfStep*grad;   
         range        = f2v1(nextPoint) - f2v1(currentPoint);
         currentPoint = nextPoint;
         path = [path, currentPoint];
    end;   
    point = currentPoint;
    path = [path(1,:);path(2,:);f2v2(path(1,:),path(2,:))];
    vMin = [point(1), point(2), f2v1(point)];
end

function [state] = isOutAbroad(point, bounds)
    state = false;
    if point(1) < bounds(1, 1) || point(1) > bounds(1, 2) ||...
       point(2) < bounds(2, 1) || point(2) > bounds(2, 2)
        state = true;
    end;
end

    
    
    

