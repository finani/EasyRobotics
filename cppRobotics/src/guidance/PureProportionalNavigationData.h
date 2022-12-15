#ifndef GUIDANCE_PURE_PROPORTIONAL_NAVIGATION_INPUT_DATA_H
#define GUIDANCE_PURE_PROPORTIONAL_NAVIGATION_INPUT_DATA_H

#include <eigen3/Eigen/Dense>

struct PureProportionalNavigationData {
  Eigen::Vector3d curPos;
  Eigen::Vector3d targetPos;

  PureProportionalNavigationData(const Eigen::Vector3d &curPos,
                                 const Eigen::Vector3d &targetPos)
      : curPos(curPos), targetPos(targetPos) {}
};

#endif // !GUIDANCE_PURE_PROPORTIONAL_NAVIGATION_INPUT_DATA_H
