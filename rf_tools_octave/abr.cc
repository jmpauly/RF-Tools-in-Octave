/* 
 * a-b rotator, discrete time simulator for RF tools
 *
 * jan 12, 2001 jmp
 *
 * (c) 2001 Board of Trustees, Leland Stanford University
 *
 */

#include <octave/oct.h>
/*#include <octave/gripes.h> */
/*#include <octave/pager.h> */


DEFUN_DLD (abr, args, nargout,
  "[a b] = abr (rf,{gx{+i*gy}}")
/*  
  abr: simulate an RF pulse using an optional gradient waveform, in
         either 1D or in 2D

  [a b] = abr(rf,x) 
        assumes a constant gradient of area 2*pi

  [a b] = abr(rf,g,x)
        1D simulation of rf with time-varying g

  [a b] = abr(rf,gx+i*gy,x,y)
        2D simulation at x*y positions")
*/
{
   octave_value_list retval;
   octave_value tmp;
   int nargin = args.length ();
   int carg;

   if ((nargin < 2) || (nargin > 4) ) {
      print_usage ("abr");
      return retval;
   } 

   /* check if these are vectors */
   if ( !( 1== args(0).rows() || 1== args(0).columns() ) ||
	!( 1== args(1).rows() || 1== args(1).columns() ) ) {
     print_usage ("abr");
     return retval;
   }

   carg = 0;

   ComplexColumnVector rf (args(0).complex_vector_value());
   int lrf = rf.length();
   carg++;

   ComplexColumnVector g (lrf);
   if (nargin == 2) {
     for (int j=0; j<lrf; j++) 
       g(j) = 2*M_PI/lrf;
   } else {
     ComplexColumnVector gt (args(carg).complex_vector_value());
     if (gt.length() != rf.length()) {
       error("RF and g are different lengths");
       return retval;
     }
     g = gt;
     carg++;
   }
       
   ColumnVector x  (args(carg).vector_value());
   int lx = x.length();
   int ly = 1;
   carg++;

   if (carg < nargin) {
     ColumnVector yt  (args(carg).vector_value());
     ly = yt.length();
   }
   ColumnVector y (ly);
   if (ly == 1) {
     y(0) = 0;
   } else {
     y = args(carg).vector_value();
   }


   ComplexMatrix a (lx, ly);
   ComplexMatrix b (lx, ly);

   double om;
   double phi;
   double nx, ny, nz;
   ComplexColumnVector av(lrf);
   ComplexColumnVector bv(lrf);
   Complex i = Complex (0.0, 1.0);

   for (int j=0; j<ly; j++)
     for (int k=0; k<lx; k++) {

       for (int m=0; m<lrf; m++) {
	 om = x(k)*real(g(m)) + y(j)*imag(g(m));
         phi = sqrt(real(rf(m)*conj(rf(m)))+om*om);

         nx = real(rf(m))/phi;
         ny = imag(rf(m))/phi;
         nz = om/phi;

         av(m) = cos(phi/2) - i * nz * sin(phi/2);
         bv(m) = -i*(nx+i*ny)*sin(phi/2);
       }

       ComplexColumnVector abt(2); 
       abt(0) = 1; abt(1) = 0; 
       for (int m=0; m<lrf; m++) {
	 ComplexMatrix rm (2,2);
         rm(0,0) = av(m); rm(0,1) = -conj(bv(m));
         rm(1,0) = bv(m); rm(1,1) = conj(av(m));
         abt = rm*abt;
       }   
       a(k,j) = abt(0);
       b(k,j) = abt(1);
     } 

   ComplexMatrix ab(lx, 2*ly);
   if (nargout == 2) {
     retval(1) = b;
     retval(0) = a;
   } else if (nargout == 1) {
     for (int j=0; j<lx; j++)
       for (int k=0; k<ly; k++) {
	 ab(j,k) = a(j,k);
         ab(j,k+ly) = b(j,k);
       }
     retval(0) = ab;
   } else {
     print_usage("abr");
   }

   return retval;
}






