#include "guidance/PureProportionalNavigation.h"

#if defined(__cplusplus)
extern "C" {
#endif

double PureProportionalNavigationCalcAccCmd(double* pCurPos, double* pTargetPos);

double PureProportionalNavigationCalcAccCmdFromLosRate(double losRate);

double* PureProportionalNavigationGetParams();

void PureProportionalNavigationSetParams(double n);

void PureProportionalNavigationSetPrevValues(double* pCurPos, double* pTargetPos);

#if defined(__cplusplus)
} // extern "C"
#endif
