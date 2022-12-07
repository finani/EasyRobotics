#ifndef FILTER_FIRST_ORDER_FILTER_CONFIG_H
#define FILTER_FIRST_ORDER_FILTER_CONFIG_H

struct FirstOrderFilterConfig {
  double cutOffFreqHz;
  double timeConstantSec;

  FirstOrderFilterConfig(double cutOffFreqHz, double timeConstantSec)
      : cutOffFreqHz(cutOffFreqHz), timeConstantSec(timeConstantSec) {}
};

#endif // !FILTER_FIRST_ORDER_FILTER_CONFIG_H
