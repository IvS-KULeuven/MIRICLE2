# Version History of the MIRICLE installation script

## Version 6.x

+ ### 13/02/2017
 + 6.00 (Wim De Meester): Move to a conda based installation. Bug 226: Tracing dependencies in MIRICLE / mirisim, Bug 232: Check installed version

## Version 5.x

+ ### 25/01/2017

  + 5.38 (Wim De Meester): Bug 270: Can no longer run simulations: mirisim (PIL?) doesn't find libjpeg.so.9

+ ### 24/01/2017

 + 5.37 (Wim De Meester): Bug 280: VisibleDeprecationWarning for float as index has become TypeError in numpy 1.12
 + 5.36 (Wim De Meester): Bug 280: VisibleDeprecationWarning for float as index has become TypeError in numpy 1.12

+ ### 23/01/2017

  + 5.35 (Wim De Meester): Bug 276: install script fails to install packages that rely on "pip install --upgrade setuptools"

+ ### 09/01/2017

  + 5.34 (Wim De Meester): Bug 140: Install sftp server - install pysftp
  + 5.33 (Wim De Meester): Bug 261: MIRICLE installation script hangs up when attempting to install the specviz module.


+ ### 05/01/2017

  + 5.32 (Wim De Meester): Bug 257: matplotlib fails to import after building with MIRICLE_install.bash --mirisim

+ ### 15/12/2016

  + 5.31 (Wim De Meester): Bug 221: mirisim: "RuntimeError: Python is not installed as a framework."

+ ### 07/12/2016

  + 5.30 (Wim De Meester): Bug 237: Preparation for MIRISim test team beta 6 release

+ ### 01/12/2016

  + 5.29 (Wim De Meester): Bug 233: Install packages from JWST Data Analysis Development Forum

+ ### 09/11/2016

  + 5.28 (Wim De Meester): Bug 213: Intel MKL FATAL ERROR: Cannot load libmkl_avx2.so or libmlk_def.so

+ ### 08/11/2016

  + 5.27 (Wim De Meester): Bug 205: Refactor to use latest version of jwst_lib

+ ### 07/11/2016

  + 5.26 (Christophe Cossou): Only load pysynphot if it changed since last download

+ ### 27/10/2016

  + 5.25 (Wim De Meester): Remove check for subversion

+ ### 25/10/2016

  + 5.24 (Wim De Meester): Bug 194: include webbpsf and poppy in the MIRICLE mirisim installation
  + 5.23 (Wim De Meester): Bug 200: Failure to install module

+ ### 28/09/2016

  + 5.22 (Steven Beard): Some small corrections, eg the order in which the packages are installed

+ ### 22/09/2016

  + 5.21 (Christophe Cossou): GitHub Issue 36: Handle miricle.org down in the script, use curl in stead of ping

+ ### 21/09/2016

  + 5.20 (Christophe Cossou): GitHub Issue 36: Handle miricle.org down in the script

+ ### 12/09/2016

  + 5.19 (Wim De Meester): Bug 167 - install failed

+ ### 01/09/2016

  + 5.18 (Wim De Meester): Bug 160 - Install script doesn't find internet connection when on WiFi
  + 5.17 (Wim De Meester): Also install requests and pillow

+ ### 29/07/2016

  + 5.16 (Wim De Meester): Some fixes for mirisim sub-releases

+ ### 26/07/2016

  + 5.15 (Wim De Meester): mirisim sub-releases

+ ### 21/06/2016

  + 5.14 (Wim De Meester): Readding stsci.distutils

+ ### 14/06/2016

  + 5.13 (Wim De Meester): New method to check the internet connection

+ ### 09/06/2016

  + 5.12 (Wim De Meester): Bug 123 - Error installing stscipython during Mirisim install

+ ### 07/06/2016

  + 5.11 (Wim De Meester): Bug 124 - Log warning re. pip upgrade

+ ### 06/06/2016

  + 5.10 (Wim De Meester): Let the install script install mirisim by default

+ ### 24/05/2016

  + 5.09 (Wim De Meester): Add functools32 to make jupyter work

+ ### 18/05/2016

  + 5.08 (Patrick Kavanagh): Removed CRDS fix (crds updated by STScI)

+ ### 17/05/2016

  + 5.07 (Wim De Meester): Bug 97: MIRIClE install script fails to install jwst_lib, jwst_pipeline and a few others.

+ ### 09/05/2016

  + 5.06 (Wim De Meester): Add jupyter and jsonschema to the installation.

+ ### 02/05/2016

  + 5.05 (Wim De Meester): Move the installation of the pysynphot datafiles before the question of the CRDS directory.

+ ### 29/04/2016

  + 5.04 (Patrick Kavanagh): Better describe the fix for the CRDS upper-case problems.

+ ### 29/04/2016

  + 5.03 (Patrick Kavanagh): Fix CRDS upper-case problems.

+ ### 18/04/2016

  + 5.02 (Wim De Meester): Bug 48 - Using MIRICLE_install.bash without a connection erases the script.

+ ### 17/03/2016

  + 5.01 (Wim De Meester): Add astropy to the installation script.

+ ### 16/03/2016

  + 5.00 (Wim De Meester): Bug 39 - Regression: can no longer import astropy from within ipython


## Older versions

+ Version 4.9  : 15/03/2016 : Wim De Meester - Bug 38 - miri no longer installs
+ Version 4.8  : 14/03/2016 : Wim De Meester - Bug 27 - Repeated runs of MIRICLE install script can fail to re-install "miri" package
+ Version 4.7  : 14/03/2016 : Wim De Meester - Bug 36 - Install stscipython to be able to use the pipeline.
+ Version 4.6  : 14/03/2016 : Wim De Meester - Bug 18 - Example simulation fails on Linux and MacBook. Make sure to check for the correct options for the script.
+ Version 4.5  : 10/03/2016 : Wim De Meester - Fix version of jwst_pipeline. Install all jwst_pipeline modules.
+ Version 4.4  : 15/02/2016 : Wim De Meester - Install gwcs manually in the script. This should fix the gwcs installation problems.
+ Version 4.3  : 03/02/2016 : Wim De Meester - Install asdf using conda. Don't try to install 'none'-package for developers.
+ Version 4.2  : 25/01/2016 : Wim De Meester - Make sure to use setuptools==18.5
+ Version 4.1  : 16/12/2015 : Wim De Meester - Add --mirisim to the command line options
+ Version 4.0  : 08/12/2015 : Wim De Meester - Work with versioning


+ Version 3.7  : 25/11/2015 : Wim De Meester - Work around LC_CTYPE problems on MAC
+ Version 3.6  : 18/11/2015 : Wim De Meester - Make MIRICLE work with anaconda 2.1.
+ Version 3.5  : 17/11/2015 : Wim De Meester - Install photutils - see Bug 10.
+ Version 3.4  : 05/11/2015 : Wim De Meester - Use /bin/bash instead of /bin/bash --login: Bug 12.
+ Version 3.3  : 14/10/2015 : Wim De Meester - Add gwcs, pysynphot, pySpecSim and mirisim to the packages to install.
+ Version 3.2  : 12/10/2015 : Wim De Meester - Add petl to the installed packages.
+ Version 3.1  : 20/08/2015 : Wim De Meester - Update to use the new package names.
+ Version 3.0  : 06/07/2015 : Wim De Meester - Use anaconda 2.2.0 as python distribution.


+ Version 2.8  : 30/03/2015 : Wim De Meester - Updated ureka to version 1.5.1
+ Version 2.7  : 23/03/2015 : Wim De Meester - Removed sloper from jwst_tools
+ Version 2.6  : 23/02/2015 : Wim De Meester - Update jwst_pipeline module, added jwst_tools
+ Version 2.5  : 27/10/2014 : Wim De Meester - Update Ureka to version 1.4.1
+ Version 2.4  : 30/06/2014 : Wim De Meester - Corrected some small things
+ Version 2.3  : 12/06/2014 : Wim De Meester - Update Ureka to version 1.4
+ Version 2.2  : 03/06/2014 : Wim De Meester - Update stsci.distutils
+ Version 2.1  : 02/06/2014 : Wim De Meester - Make installation of IRAF optional
+ Version 2.0  : 02/06/2014 : Wim De Meester - Add password and username for crds


+ Version 1.9  : 22/05/2014 : Wim De Meester - Updated to use jwst_lib, jwst_pipeline and jwst_tools
+ Version 1.8  : 07/03/2014 : Wim De Meester - Updated to new svn location
+ Version 1.7  : 07/02/2014 : Wim De Meester, Ruyman Azzollini - Added some jwstlib packages
+ Version 1.6  : 06/02/2014 : Wim De Meester - Rename pyMAS to MIRICLE, added --help option to see the help
+ Version 1.5  : 05/12/2013 : Fred Lahuis    - Move path removal to earlier in ur_setup
+ Version 1.4  : 05/12/2013 : Fred Lahuis    - Adapted to Ureka release 1.0
+ Version 1.3  : 26/11/2013 : Fred Lahuis    - Set shell in the beginning of the script
+ Version 1.2  : 22/11/2013 : Wim De Meester - Resolved installation problems where the default shell is tcsh
+ Version 1.1  : 16/11/2013 : Fred Lahuis    - resolved bogus svn install error messages; include kapteyn package;
+ Version 1.0  : 15/11/2013 : Fred Lahuis    - Move to ureka 1.0beta6 with more packages; cleanup pyMAS package list, gfortran library incompatibility


+ Version 0.9  : 15/11/2013 : Fred Lahuis    - Corrected unset statements, cleaned download commands, added pipeline subpackages (temp.solution), removed pyds9 (incl.in ureka)
+ Version 0.8  : 15/11/2013 : Wim De Meester - Corrected unset statements, added crds and pipeline modules
+ Version 0.7  : 13/11/2013 : Wim De Meester - Added pysynphot pywcs asciidata asciitable
+ Version 0.6  : 12/11/2013 : Wim De Meester - Enable iraf
+ Version 0.5  : 31/10/2013 : Wim De Meester - Install pysynphot and pywcs
+ Version 0.4  : 06/09/2013 : Wim De Meester - Make output less verbose. Add a --verbose option to show all installed python packages
+ Version 0.3  : 03/09/2013 : Wim De Meester - Use latest svn revision for jwstlib
+ Version 0.2  : 30/08/2013 : Wim De Meester - Only install needed packages. Use svn revision 2108 for jwstlib
+ Version 0.1  : 28/08/2013 : Wim De Meester - Added version numbering and automatic updating of script.


+ Version 19/08/2013 : Fred Lahuis - solved tcsh issues
+ Version 01/08/2013 : Wim De Meester - Added checks for the existence of curl, let the script fail in the beginning if svn is not found
+ Version 25/06/2013 : Fred Lahuis - more logic and additional packages
+ Version 21/06/2013 : Wim De Meester
+ Version 17/05/2013 : Fred Lahuis
