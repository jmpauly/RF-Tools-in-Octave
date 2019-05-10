# RF-Tools-in-Octave
RF pulse design tools for Magnetic Resonance Imaging 

There is documentation in old_manual.pdf, as well as online help for most routines.

The simulater may need to be compiled.  Execute the command

   mkoctfile abr.cc

to produce abr.oct.  There is also an m-file version abrm.m if your octave installation doesn't support dynamically loaded modules.

You need the signal toolbox

  octave> pkg install -forge signal 

and you will need to load it each time

  octave> pkg load signal

To run the demos from the command line,

  octave> addpath demo
  octave> rf_tools_demo
  
There is also a Jupyter Notebook rf_tools_demo.ipynb, and an html version rf_tools_demo.html.  These require the octave kernel for Jupyter, which is available on GitHub.

This was converted from matlab.  Not everything is working yet, like dzepse.m.
