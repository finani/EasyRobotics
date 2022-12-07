#include "../../src/filter/FirstOrderFilter.h"
#include <gtest/gtest.h>
#include <unordered_map>

auto RunFilter(int loopHz, FirstOrderFilter<double> &filter,
               double durationTimeSec, double targetValue) {
  auto settlingTimeSec = 1'000'000.0;
  auto settlingTimeCriterion = 0.02; // 98%
  auto maxValue = 0.0;

  auto timeSec = 0.0;
  while (timeSec < durationTimeSec) {
    auto prevValue = filter.GetPrevOutput();
    auto value = filter.Calc(targetValue);
    timeSec += 1.0 / loopHz;

    // Settling Time
    if ((std::abs(targetValue - value) < targetValue * settlingTimeCriterion) &&
        (std::abs(targetValue - prevValue) >
         targetValue * settlingTimeCriterion)) {
      settlingTimeSec = timeSec;
    }

    // Overshoot
    maxValue = std::max(maxValue, value);
  }
  auto overShootPercent = std::max(0.0, maxValue - 1.0) * 100.0;

  std::unordered_map<std::string, double> result;
  result.insert({"settlingTimeSec", settlingTimeSec});
  result.insert({"overShootPercent", overShootPercent});

  return result;
}

TEST(FirstOrderFilterTestSuite, resetTestCase) {
  auto loopHz = 50;
  auto timeConstantSec = 0.1;
  auto config = FirstOrderFilterConfig(0.0, timeConstantSec);
  FirstOrderFilter<double> filter(loopHz);
  filter.SetParams(config);

  EXPECT_THROW(
      {
        filter.ResetFilter();
        auto durationTimeSec = 1.0;
        auto targetValue = 1.0;
        RunFilter(loopHz, filter, durationTimeSec, targetValue);
      },
      std::runtime_error);
}

TEST(FirstOrderFilterTestSuite, cteConvergeTestCase) {
  auto loopHz = 50;
  auto timeConstantSec = 0.1;
  auto config = FirstOrderFilterConfig(0.0, timeConstantSec);
  FirstOrderFilter<double> filter(loopHz);
  filter.SetParams(config);

  auto durationTimeSec = 1.0;
  auto targetValue = 1.0;
  auto result = RunFilter(loopHz, filter, durationTimeSec, targetValue);

  EXPECT_LT(result["settlingTimeSec"], 0.5);  // 0.44s
  EXPECT_EQ(result["overShootPercent"], 0.0); // no Overshoot
}
