#ifndef GUIDANCE_PROPORTIONAL_NAVIGATION_CONFIG_H
#define GUIDANCE_PROPORTIONAL_NAVIGATION_CONFIG_H

struct ProportionalNavigationConfig {
  double n; // 3 to 5

  explicit ProportionalNavigationConfig(double n) : n(n) {}
};

#endif // !GUIDANCE_PROPORTIONAL_NAVIGATION_CONFIG_H
