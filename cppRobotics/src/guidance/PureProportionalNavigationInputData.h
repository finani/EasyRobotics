#ifndef GUIDANCE_PURE_PROPORTIONAL_NAVIGATION_INPUT_DATA_H
#define GUIDANCE_PURE_PROPORTIONAL_NAVIGATION_INPUT_DATA_H

#include <array>

struct PureProportionalNavigationInputData {
  std::array<double, 3> curPos;
  std::array<double, 3> targetPos;

  explicit PureProportionalNavigationInputData(
      const std::array<double, 3> &curPos,
      const std::array<double, 3> &targetPos)
      : curPos(curPos), targetPos(targetPos) {}
};

#endif // !GUIDANCE_PURE_PROPORTIONAL_NAVIGATION_INPUT_DATA_H
