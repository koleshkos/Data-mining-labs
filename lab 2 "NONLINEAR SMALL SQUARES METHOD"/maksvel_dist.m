function maks = maksvel_dist( params, x )
a = params(1);
maks = sqrt(2/pi)*(a^3)*(x.^2).*exp(-a^2*(x.^2)/2);
end

