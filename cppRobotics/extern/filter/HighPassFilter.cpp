#include "HighPassFilter.h"

static HighPassFilter<double> highPassFilter(50);
static double params[2];

double HighPassFilterCalc(double curInput) {
  return highPassFilter.Calc(curInput);
}

double* HighPassFilterGetParams() {
  FirstOrderFilterConfig config = highPassFilter.GetParams();
  params[0] = config.cutOffFreqHz;
  params[1] = config.timeConstantSec;
  return params;
}

void HighPassFilterSetParams(double cutOffFreqHz, double timeConstantSec) {
  FirstOrderFilterConfig config = {cutOffFreqHz, timeConstantSec};
  highPassFilter.SetParams(config);
}

void HighPassFilterResetFilter() {
  highPassFilter.ResetFilter();
}

void HighPassFilterResetPrevValues() {
  highPassFilter.ResetPrevValues();
}
