function f = gaussian_distribution(x, mu, sigma)
    p = -(1/2) * ((x - mu)/sigma) .^ 2;
    A = 1/(sigma * sqrt(2*pi));
    f = A.*exp(p); 
end