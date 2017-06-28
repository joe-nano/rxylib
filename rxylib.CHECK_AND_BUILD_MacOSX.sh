#!/bin/bash
#
# =================================================================================================
# rxylib.CHECK_AND_BUILD shell script
# author: Sebastian Kreutzer
# date: 2017-06-28
#
# Customized R check and build routine for the R package 'rxylib'
# =================================================================================================
#
#
# CONFIG AND DEFINITIONS
# =================================================================================================
#
export TERM=xterm
PATHPACKAGE=$(dirname $0)

#
check_status(){
  if [ $? == 0 ]; then
    echo "[OK]"
  else
    echo "[FAILED]"
  fi
}
#
#
# REMOVING UNWANTED FILES
# =================================================================================================
echo ""
echo -ne "Set package path to " ${PATHPACKAGE} "\n\n"
echo "[PREPARE FOR PACKAGE CHECK]"
echo ""
#

  echo -ne "-> Clean rxylib.BuildResults folder ... \t"
  find ${PATHPACKAGE}/rxylib.BuildResults -type f -exec rm {} \;
  check_status

  echo -ne "-> Remove .DS_Store ... \t\t\t"
  find ${PATHPACKAGE} -name ".DS_Store" -depth -exec rm {} \;
  check_status

  echo -ne "-> Remove .Rhistory ... \t\t\t"
  find ${PATHPACKAGE} -name ".Rhistory" -depth -exec rm {} \;
  check_status

  echo -ne "-> Remove .RData ... \t\t\t\t"
  find ${PATHPACKAGE} -name ".RData" -depth -exec rm {} \;
  check_status

  echo -ne "-> Remove .RcppExports.cpp ... \t\t\t"
  find ${PATHPACKAGE}/src -name "RcppExports.cpp" -depth -exec rm {} \;
  check_status

  echo -ne "-> Remove .RcppExports.R ... \t\t\t"
  find ${PATHPACKAGE}/R -name "RcppExports.R" -depth -exec rm {} \;
  check_status


# Rcpp
# =================================================================================================
  echo -ne "-> Build Rcpp ... \t\t\t\t"
  eval R CMD BATCH --no-timing ${PATHPACKAGE}/rxylib.BuildScripts/rxylib.PBS_Rcpp.R /dev/null
  check_status

# REMOVE NAMESPACE
# =================================================================================================
  echo -ne "-> Remove NAMESPACE ... \t\t\t"
  find ${PATHPACKAGE} -name "NAMESPACE" -depth -exec rm {} \;
  check_status

# roxygen2
# =================================================================================================
  echo -ne "-> Create empty NAMESPACE file... \t\t"
  echo '# Generated by roxygen2 (4.1.0.9001): do not edit by hand' > NAMESPACE
  check_status

  echo -ne "-> Build documentation ... \t\t\t"
  eval R CMD BATCH --no-timing ${PATHPACKAGE}/rxylib.BuildScripts/rxylib.PBS_roxygen2.R /dev/null
  check_status

  echo -ne "-> Add formats ... \t\t\t\t"
  eval R CMD BATCH --no-timing ${PATHPACKAGE}/rxylib.BuildScripts/rxylib.PBS_Formats.R /dev/null
  check_status

#
# BUILD PACKAGE
# =================================================================================================
echo ""
echo "[BUILD PACKAGE]"
echo ""

  eval R CMD build ${PATHPACKAGE}

#
# CHECK PACKAGE
# =================================================================================================
echo ""
echo "[CHECK PACKAGE]"
echo ""

  ##eval R CMD check --timings --as-cran ${PATHPACKAGE}/rxylib*.tar.gz
  eval R CMD check --timings  ${PATHPACKAGE}/rxylib*.tar.gz

#
# INSTALL PACKAGE
# =================================================================================================
echo ""
echo "[INSTALL PACKAGE]"
echo ""

  eval R CMD INSTALL --build ${PATHPACKAGE}/


#
# COPY FILES AND CLEANING UP
# =================================================================================================
echo ""
echo "[OUTRO]"
echo ""

#
# COMPILE FUNCTION PARAMETER LIST
# =================================================================================================

  echo -ne "-> Moving packge source files (*.tar.gz) ... \t"
  mv rxylib_*.tar.gz rxylib.BuildResults/ &>/dev/null
  check_status

  echo -ne "-> Moving packge compiles package (*.tgz) ... \t"
  mv rxylib_*.tgz rxylib.BuildResults/ &>/dev/null
  check_status

  echo -ne "-> Copy manual ... \t\t\t\t"
  cp rxylib.Rcheck/rxylib-manual.pdf rxylib.BuildResults/rxylib-manual.pdf &>/dev/null
  check_status

  echo -ne "-> Copy check results ... \t\t\t"
  cp rxylib.Rcheck/rxylib-Ex.pdf rxylib.BuildResults/rxylib-Ex.pdf &>/dev/null
  check_status

  echo -ne "-> Remove rxylib.Rcheck ... \t\t\t"
  rm -r ${PATHPACKAGE}/rxylib.Rcheck &>/dev/null
  check_status

  echo -ne "-> Remove src/*.so ... \t\t\t\t"
  find ${PATHPACKAGE}/src -name "*.so" -depth -exec rm {} \;
  check_status

  echo -ne "-> Remove src/*.o ... \t\t\t\t"
  find ${PATHPACKAGE}/src -name "*.o" -depth -exec rm {} \;
  check_status

  echo -ne "-> Remove src/xylib/*.o ... \t\t\t"
  find ${PATHPACKAGE}/src/xylib -name "*.o" -depth -exec rm {} \;
  check_status

  echo -ne "-> Remove src/*.o* ... \t\t\t\t"
  find ${PATHPACKAGE}/src -name "*.o*" -depth -exec rm {} \;
  check_status

  echo -ne "-> Remove src/*.rds ... \t\t\t"
  find ${PATHPACKAGE}/src -name "*.rds" -depth -exec rm {} \;
  check_status

  echo ""
  echo "[FINE]"
