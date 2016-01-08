[X, Y] = meshgrid(0.01:0.01:1, 0.01:0.01:1);
Z = 11*X.*log10(X).*Y.*(Y-1)+exp(-((25 ...
            *X - 25/exp(1)).^2+(25*Y-25/2).^2).^3)./25;
surfl(X, Y, Z);
shading flat
colormap(pink)
view()