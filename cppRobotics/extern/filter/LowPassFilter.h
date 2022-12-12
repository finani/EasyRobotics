#include "../../src/filter/LowPassFilter.h"

#if defined(__cplusplus)
extern "C" {
#endif

double LowPassFilterCalc(double curInput);

double* LowPassFilterGetParams();

void LowPassFilterSetParams(double cutOffFreqHz, double timeConstantSec);

void LowPassFilterResetFilter();

void LowPassFilterResetPrevValues();

#if defined(__cplusplus)
} // extern "C"
#endif
