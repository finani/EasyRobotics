#ifndef FILTER_LOW_PASS_FILTER_CONFIG_H
#define FILTER_LOW_PASS_FILTER_CONFIG_H

struct LowPassFilterConfig {
  double cutOffFreqHz;
  double timeConstantSec;

  LowPassFilterConfig(double cutOffFreqHz, double timeConstantSec)
      : cutOffFreqHz(cutOffFreqHz), timeConstantSec(timeConstantSec) {}
};

#endif // !FILTER_LOW_PASS_FILTER_CONFIG_H
