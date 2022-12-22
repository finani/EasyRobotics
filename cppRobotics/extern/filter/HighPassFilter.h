#include "filter/HighPassFilter.h"

#if defined(__cplusplus)
extern "C" {
#endif

double HighPassFilterCalc(double curInput);

double* HighPassFilterGetParams();

void HighPassFilterSetParams(double cutOffFreqHz, double timeConstantSec);

void HighPassFilterResetFilter();

void HighPassFilterResetPrevValues();

#if defined(__cplusplus)
} // extern "C"
#endif
