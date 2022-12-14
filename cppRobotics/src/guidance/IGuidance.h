#ifndef GUIDANCE_IGUIDANCE_H
#define GUIDANCE_IGUIDANCE_H

template <typename InputData, typename Config> class IGuidance {
public:
  IGuidance() = default;
  ~IGuidance() = default;

  virtual double CalcAccCmd(const InputData &curInputData) = 0;
  virtual double CalcAccCmd(const double losRate) = 0;
  virtual Config GetParams() = 0;
  virtual void SetParams(const Config &config) = 0;

private:
  virtual bool CheckFilterValid() = 0;
};

#endif // !GUIDANCE_IGUIDANCE_H
