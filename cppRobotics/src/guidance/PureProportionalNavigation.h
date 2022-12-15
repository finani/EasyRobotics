#ifndef GUIDANCE_PROPORTIONAL_NAVIGATION_H
#define GUIDANCE_PROPORTIONAL_NAVIGATION_H

#include <cmath>

#include "IGuidance.h"
#include "ProportionalNavigationConfig.h"
#include "PureProportionalNavigationData.h"

// https://en.wikipedia.org/wiki/Proportional_navigation

class ProportionalNavigation : public IGuidance<PureProportionalNavigationData,
                                                ProportionalNavigationConfig> {
public:
  explicit ProportionalNavigation(int hz)
      : hz_(hz), isSetParams_(false), proportionalNavigationConfig_(0.0),
        prevToTargetVector_(), prevToTargetVectorNorm_(0.0){};
  ~ProportionalNavigation() = default;

  ProportionalNavigation(const ProportionalNavigation &other) = default;
  ProportionalNavigation &
  operator=(const ProportionalNavigation &other) = default;

  ProportionalNavigation(ProportionalNavigation &&other) = default;
  ProportionalNavigation &operator=(ProportionalNavigation &&other) = default;

  double
  CalcAccCmd(const PureProportionalNavigationData &curInputData) override {
    if (isSetParams_ == true) {
      Eigen::Vector3d curToTargetVector =
          curInputData.targetPos - curInputData.curPos;
      double curToTargetVectorNorm = curToTargetVector.norm();

      double deltaLos =
          std::acos(curToTargetVector.dot(prevToTargetVector_) /
                    curToTargetVectorNorm / prevToTargetVectorNorm_);

      double losRate = deltaLos * hz_;
      double accCmd = proportionalNavigationConfig_.n * losRate;

      prevToTargetVector_ = curToTargetVector;
      prevToTargetVectorNorm_ = curToTargetVectorNorm;
      return accCmd;
    } else {
      throw std::runtime_error(
          "ProportionalNavigation::Calc: Params are not set.");
    }
  }

  double CalcAccCmdFromLosRate(double losRate) override {
    double accCmd = proportionalNavigationConfig_.n * losRate;
    return accCmd;
  }

  ProportionalNavigationConfig GetParams() override {
    return proportionalNavigationConfig_;
  }

  void SetParams(const ProportionalNavigationConfig &config) override {
    proportionalNavigationConfig_ = config;
    isSetParams_ = CheckFilterValid();
  }

  void SetPrevData(const PureProportionalNavigationData &prevData) {
    prevToTargetVector_[0] = prevData.targetPos[0] - prevData.curPos[0];
    prevToTargetVector_[1] = prevData.targetPos[1] - prevData.curPos[1];
    prevToTargetVector_[2] = prevData.targetPos[2] - prevData.curPos[2];
    prevToTargetVectorNorm_ =
        std::sqrt(prevToTargetVector_[0] * prevToTargetVector_[0] +
                  prevToTargetVector_[1] * prevToTargetVector_[1] +
                  prevToTargetVector_[2] * prevToTargetVector_[2]);
  }

private:
  bool CheckFilterValid() override {
    if (proportionalNavigationConfig_.n >= 3.0 &&
        proportionalNavigationConfig_.n <= 5.0) {
      return true;
    } else {
      return false;
    }
  }

  int hz_;

  bool isSetParams_;

  ProportionalNavigationConfig proportionalNavigationConfig_;

  Eigen::Vector3d prevToTargetVector_;
  double prevToTargetVectorNorm_;
};

#endif // !GUIDANCE_PROPORTIONAL_NAVIGATION_H
