#include "LowPassFilter.h"

static LowPassFilter<double> lowPassFilter(50);
static double params[2];

double LowPassFilterCalc(double curInput) {
  return lowPassFilter.Calc(curInput);
}

double* LowPassFilterGetParams() {
  FirstOrderFilterConfig config = lowPassFilter.GetParams();
  params[0] = config.cutOffFreqHz;
  params[1] = config.timeConstantSec;
  return params;
}

void LowPassFilterSetParams(double cutOffFreqHz, double timeConstantSec) {
  FirstOrderFilterConfig config = {cutOffFreqHz, timeConstantSec};
  lowPassFilter.SetParams(config);
}

void LowPassFilterResetFilter() {
  lowPassFilter.ResetFilter();
}

void LowPassFilterResetPrevValues() {
  lowPassFilter.ResetPrevValues();
}
