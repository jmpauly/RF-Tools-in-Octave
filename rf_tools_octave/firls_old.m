function h = firls(n, f, a, w)

m = 16;
nm = n*m;

isodd = (floor(n/2) != n/2);

if isodd,
  nc = (n+1)/2;
  E = zeros(nm/2+1,nc);
  om = [0:nm/2]/nm;
  for j=1:nc,
    E(:,j) = cos(om*2*pi*(j-1))';
  end;
  H = zeros(nm/2+1,1);
  Wd = zeros(nm/2+1,1);
  be = 1+f*(nm/2);
else
  nc = n/2;
  E = zeros(nm/2,nc);
  om = [0.5:((nm/2)-0.5)]/nm;
  for j=1:nc,
    E(:,j) = cos(om*2*pi*(j-0.5))';
  end;
  H = zeros(nm/2,1);
  Wd = zeros(nm/2,1);
  be = 1+f*((nm-1)/2);
endif



for j=1:2:length(be),
  for k=be(j):be(j+1),
    be(j)
    be(j+1)
    H(k) = a(j);
    j
    Wd(k) = w((j+1)/2);
    (j+1)/2
  end
end
W = diag(Wd);

h = (E'*W*E) \ (E'*H);

if isodd,
 h = [h(nc:-1:2);  2*h(1); h(2:nc)]/2;
else
 h = [h(nc:-1:1);  h(1:nc)]/2;
endif;

