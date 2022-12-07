#include "FirstOrderFilter.h"

static FirstOrderFilter<double> firstOrderFilter(50);

double FirstOrderFilterCalc(double curInput) {
  return firstOrderFilter.Calc(curInput);
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
