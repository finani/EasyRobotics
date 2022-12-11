#include "FirstOrderFilter.h"

static FirstOrderFilter<double> firstOrderFilter(50);
static double params[2];

double FirstOrderFilterCalc(double curInput) {
  return firstOrderFilter.Calc(curInput);
}

double* FirstOrderFilterGetParams() {
  FirstOrderFilterConfig config = firstOrderFilter.GetParams();
  params[0] = config.cutOffFreqHz;
  params[1] = config.timeConstantSec;
  return params;
}

void FirstOrderFilterSetParams(double cutOffFreqHz, double timeConstantSec) {
  FirstOrderFilterConfig config = {cutOffFreqHz, timeConstantSec};
  firstOrderFilter.SetParams(config);
}

void FirstOrderFilterResetFilter() {
  firstOrderFilter.ResetFilter();
}

void FirstOrderFilterResetPrevValues() {
  firstOrderFilter.ResetPrevValues();
}
