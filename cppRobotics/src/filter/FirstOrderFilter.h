#ifndef FILTER_FIRST_ORDER_FILTER_H
#define FILTER_FIRST_ORDER_FILTER_H

#include <math.h>

#include <stdexcept>

#include "FirstOrderFilterConfig.h"
#include "IFilter.h"

template <typename T>
class FirstOrderFilter : public IFilter<T, FirstOrderFilterConfig> {
public:
  explicit FirstOrderFilter(int hz)
      : hz_(hz), isSetParams_(false), firstOrderFilterConfig_(0, 0),
        prevOutput_(){};
  ~FirstOrderFilter() = default;

  FirstOrderFilter(const FirstOrderFilter &other) = default;
  FirstOrderFilter &operator=(const FirstOrderFilter &other) = default;

  FirstOrderFilter(FirstOrderFilter &&other) = default;
  FirstOrderFilter &operator=(FirstOrderFilter &&other) = default;

  T Calc(const T &curInput) override {
    if (isSetParams_ == true) {
      double iRC =
          2.0 * M_PI * firstOrderFilterConfig_.cutOffFreqHz * (1.0 / hz_);
      double alpha = iRC / (iRC + 1.0);
      T curOutput = curInput * alpha + prevOutput_ * (1.0 - alpha);
      prevOutput_ = curOutput;
      return curOutput;
    } else {
      throw std::runtime_error("FirstOrderFilter::Calc: Params are not set.");
    }
  }

  T Calc(const T &curInput, const FirstOrderFilterConfig &config) override {
    SetParams(config);
    return Calc(curInput);
  }

  FirstOrderFilterConfig GetParams() override {
    return firstOrderFilterConfig_;
  }

  void SetParams(const FirstOrderFilterConfig &config) override {
    firstOrderFilterConfig_ = config;
    if (firstOrderFilterConfig_.cutOffFreqHz == 0.0 &&
        firstOrderFilterConfig_.timeConstantSec != 0.0) {
      firstOrderFilterConfig_.cutOffFreqHz =
          1.0 / (2.0 * M_PI * firstOrderFilterConfig_.timeConstantSec);
    }
    isSetParams_ = CheckFilterValid();
  }

  void ResetFilter() override {
    firstOrderFilterConfig_ = {0, 0};
    isSetParams_ = false;
    ResetPrevValues();
  }

  void ResetPrevValues() override { prevOutput_ = {}; }

  T GetPrevOutput() override { return prevOutput_; }

  void SetPrevOutput(const T &prevOutput) { prevOutput_ = prevOutput; }

private:
  bool CheckFilterValid() override {
    if (firstOrderFilterConfig_.cutOffFreqHz != 0.0) {
      return true;
    } else {
      return false;
    }
  }

  int hz_;

  bool isSetParams_;
  FirstOrderFilterConfig firstOrderFilterConfig_;

  T prevOutput_;
};

#endif // !FILTER_FIRST_ORDER_FILTER_H
