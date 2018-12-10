function euclidean = euclideanFunction(x1A,x2A,x3A,x4A,x5A,x1B,x2B,x3B,x4B,x5B)
    a = (x1B-x1A)^2;
    b = (x2B-x2A)^2;
    c = (x3B-x3A)^2;
    d = (x4B-x4A)^2;
    e = (x5B-x5A)^2;
    hasil = a + b + c + d + e;
    euclidean = sqrt(hasil);
end