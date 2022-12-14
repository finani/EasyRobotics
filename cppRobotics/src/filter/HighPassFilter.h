#ifndef FILTER_HIGH_PASS_FILTER_H
#define FILTER_HIGH_PASS_FILTER_H

#include <cmath>
#include <stdexcept>

#include "FirstOrderFilterConfig.h"
#include "IFilter.h"

// https://en.wikipedia.org/wiki/High-pass_filter

template <typename T>
class HighPassFilter : public IFilter<T, FirstOrderFilterConfig> {
public:
  explicit HighPassFilter(int hz)
      : dt_(1.0 / hz), alpha_(0.0), isSetParams_(false),
        lowPassFilterConfig_(0.0, 0.0), prevInput_(), prevOutput_(){};
  ~HighPassFilter() = default;

  HighPassFilter(const HighPassFilter &other) = default;
  HighPassFilter &operator=(const HighPassFilter &other) = default;

  HighPassFilter(HighPassFilter &&other) = default;
  HighPassFilter &operator=(HighPassFilter &&other) = default;

  T Calc(const T &curInput) override {
    if (isSetParams_ == true) {
      T curOutput =
          alpha_ * prevOutput_ + (1.0 - alpha_) * (curInput - prevInput_);
      prevInput_ = curInput;
      prevOutput_ = curOutput;
      return curOutput;
    } else {
      throw std::runtime_error("HighPassFilter::Calc: Params are not set.");
    }
  }

  T Calc(const T &curInput, const FirstOrderFilterConfig &config) override {
    SetParams(config);
    return Calc(curInput);
  }

  FirstOrderFilterConfig GetParams() override { return lowPassFilterConfig_; }

  void SetParams(const FirstOrderFilterConfig &config) override {
    lowPassFilterConfig_ = config;
    if (lowPassFilterConfig_.cutOffFreqHz == 0.0 &&
        lowPassFilterConfig_.timeConstantSec != 0.0) {
      lowPassFilterConfig_.cutOffFreqHz =
          1.0 / (2.0 * M_PI * lowPassFilterConfig_.timeConstantSec);
    }
    if (lowPassFilterConfig_.cutOffFreqHz != 0.0 &&
        lowPassFilterConfig_.timeConstantSec == 0.0) {
      lowPassFilterConfig_.timeConstantSec =
          1.0 / (2.0 * M_PI * lowPassFilterConfig_.cutOffFreqHz);
    }

    double dtOverRc = dt_ * 2.0 * M_PI * lowPassFilterConfig_.cutOffFreqHz;
    alpha_ = 1.0 / (1.0 + dtOverRc);
    isSetParams_ = CheckFilterValid();
  }

  void ResetFilter() override {
    lowPassFilterConfig_ = {0.0, 0.0};
    alpha_ = 0.0;
    isSetParams_ = false;
    ResetPrevValues();
  }

  void ResetPrevValues() override { prevOutput_ = {}; }

  T GetPrevOutput() override { return prevOutput_; }

  void SetPrevOutput(const T &prevOutput) { prevOutput_ = prevOutput; }

private:
  bool CheckFilterValid() override {
    if (lowPassFilterConfig_.cutOffFreqHz != 0.0) {
      return true;
    } else {
      return false;
    }
  }

  double dt_;
  double alpha_;

  bool isSetParams_;
  FirstOrderFilterConfig lowPassFilterConfig_;

  T prevInput_;
  T prevOutput_;
};

#endif // !FILTER_HIGH_PASS_FILTER_H
