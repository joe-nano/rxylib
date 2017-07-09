// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// get_supportedFormats
RcppExport SEXP get_supportedFormats();
RcppExport SEXP rxylib_get_supportedFormats() {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    rcpp_result_gen = Rcpp::wrap(get_supportedFormats());
    return rcpp_result_gen;
END_RCPP
}
// get_version
Rcpp::CharacterVector get_version();
RcppExport SEXP rxylib_get_version() {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    rcpp_result_gen = Rcpp::wrap(get_version());
    return rcpp_result_gen;
END_RCPP
}
// read_data
RcppExport SEXP read_data(std::string path, std::string format_name, std::string options);
RcppExport SEXP rxylib_read_data(SEXP pathSEXP, SEXP format_nameSEXP, SEXP optionsSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< std::string >::type path(pathSEXP);
    Rcpp::traits::input_parameter< std::string >::type format_name(format_nameSEXP);
    Rcpp::traits::input_parameter< std::string >::type options(optionsSEXP);
    rcpp_result_gen = Rcpp::wrap(read_data(path, format_name, options));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"rxylib_get_supportedFormats", (DL_FUNC) &rxylib_get_supportedFormats, 0},
    {"rxylib_get_version", (DL_FUNC) &rxylib_get_version, 0},
    {"rxylib_read_data", (DL_FUNC) &rxylib_read_data, 3},
    {NULL, NULL, 0}
};

RcppExport void R_init_rxylib(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
