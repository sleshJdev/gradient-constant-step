function zM = f2v2( xM, yM )    
    %zM  = 2*(yM-xM.^2)+(100*(1-xM)).^2;
    %zM = 2*cos(pi*(yM - xM))+sin(100*(1-xM).^2);
    %zM = 4*(xM - 5).^2 + (yM - 6).^2;
    %zM = 2*sin(2*pi*xM).*cos(2.5*pi*yM).*(1-xM.^2).*(1-yM);
    zM = sin(1/2 * xM.^2 + 1/4 * yM.^2 + 3).*cos(2*xM + 1 + exp(yM));
end

