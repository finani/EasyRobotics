#include "PureProportionalNavigation.h"

static ProportionalNavigation proportionalNavigation(50);
static double pParams[1];

double PureProportionalNavigationCalcAccCmd(double* pCurPos, double* pTargetPos) {
  Eigen::Vector3d curPos = {pCurPos[0], pCurPos[1], pCurPos[2]};
  Eigen::Vector3d targetPos = {pTargetPos[0], pTargetPos[1], pTargetPos[2]};
  PureProportionalNavigationData curInputData = {curPos, targetPos};
  return proportionalNavigation.CalcAccCmd(curInputData);
}

double PureProportionalNavigationCalcAccCmdFromLosRate(double losRate) {
  return proportionalNavigation.CalcAccCmdFromLosRate(losRate);
}

double* PureProportionalNavigationGetParams() {
  ProportionalNavigationConfig config = proportionalNavigation.GetParams();
  pParams[0] = config.n;
  return pParams;
}

void PureProportionalNavigationSetParams(double n) {
  ProportionalNavigationConfig config{n};
  proportionalNavigation.SetParams(config);
}

void PureProportionalNavigationSetPrevValues(double* pCurPos, double* pTargetPos) {
  Eigen::Vector3d curPos = {pCurPos[0], pCurPos[1], pCurPos[2]};
  Eigen::Vector3d targetPos = {pTargetPos[0], pTargetPos[1], pTargetPos[2]};
  PureProportionalNavigationData prevInputData = {curPos, targetPos};
  proportionalNavigation.SetPrevData(prevInputData);
}
