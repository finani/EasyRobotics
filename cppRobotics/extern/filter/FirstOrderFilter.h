#include "../../src/filter/FirstOrderFilter.h"

#if defined(__cplusplus)
extern "C" {
#endif

double FirstOrderFilterCalc(double curInput);

void FirstOrderFilterSetParams(double cutOffFreqHz, double timeConstantSec);

void FirstOrderFilterResetFilter();

void FirstOrderFilterResetPrevValues();

#if defined(__cplusplus)
} // extern "C"
#endif
