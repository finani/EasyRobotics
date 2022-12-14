#include "../../src/guidance/PureProportionalNavigation.h"

#if defined(__cplusplus)
extern "C" {
#endif

double PureProportionalNavigationCalcAccCmd(double* curPos, double* targetPos);

double PureProportionalNavigationCalcAccCmdFromLosRate(double losRate);

double* PureProportionalNavigationGetParams();

void PureProportionalNavigationSetParams(double n);

#if defined(__cplusplus)
} // extern "C"
#endif
