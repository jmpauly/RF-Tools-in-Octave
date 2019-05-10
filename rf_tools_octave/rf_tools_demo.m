%
%	Demo for the rf_tools octave package
%
%	ISMRM 2019, Montreal Canada
%
%	Run this at the octave prompt with
%
%       octave> rf_tools_demo
%
%

type demo/intro.txt

opt = input("Which demo (0 for all):  ");

if ((opt == 1)|| opt == 0),
  abr_demo
end

if ((opt == 2)|| opt == 0),
  slr_demo
end

if ((opt == 3)|| opt == 0),
  min_max_demo
end

if ((opt == 4)|| opt == 0),
  dz2d_demo
end

%if ((opt == 5)|| opt == 0),
  %epse_demo
%  disp("EPSE is currently under octave conversion! Check back soon.");
%end

