#ifndef FILTER_LOW_PASS_FILTER_H
#define FILTER_LOW_PASS_FILTER_H

#include <math.h>

#include <stdexcept>

#include "LowPassFilterConfig.h"
#include "IFilter.h"

template <typename T>
class LowPassFilter : public IFilter<T, LowPassFilterConfig> {
public:
  explicit LowPassFilter(int hz)
      : hz_(hz), isSetParams_(false), lowPassFilterConfig_(0, 0),
        prevOutput_(){};
  ~LowPassFilter() = default;

  LowPassFilter(const LowPassFilter &other) = default;
  LowPassFilter &operator=(const LowPassFilter &other) = default;

  LowPassFilter(LowPassFilter &&other) = default;
  LowPassFilter &operator=(LowPassFilter &&other) = default;

  T Calc(const T &curInput) override {
    if (isSetParams_ == true) {
      double iRC =
          2.0 * M_PI * lowPassFilterConfig_.cutOffFreqHz * (1.0 / hz_);
      double alpha = iRC / (iRC + 1.0);
      T curOutput = curInput * alpha + prevOutput_ * (1.0 - alpha);
      prevOutput_ = curOutput;
      return curOutput;
    } else {
      throw std::runtime_error("LowPassFilter::Calc: Params are not set.");
    }
  }

  T Calc(const T &curInput, const LowPassFilterConfig &config) override {
    SetParams(config);
    return Calc(curInput);
  }

  LowPassFilterConfig GetParams() override {
    return lowPassFilterConfig_;
  }

  void SetParams(const LowPassFilterConfig &config) override {
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
    isSetParams_ = CheckFilterValid();
  }

  void ResetFilter() override {
    lowPassFilterConfig_ = {0, 0};
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

  int hz_;

  bool isSetParams_;
  LowPassFilterConfig lowPassFilterConfig_;

  T prevOutput_;
};

#endif // !FILTER_LOW_PASS_FILTER_H
