#ifndef FILTER_IFILTER_H
#define FILTER_IFILTER_H

template <typename T, typename Config> class IFilter {
public:
  IFilter() = default;
  virtual ~IFilter() = default;

  virtual T Calc(const T &curInput) = 0;
  virtual T Calc(const T &curInput, const Config &config) = 0;
  virtual Config GetParams() = 0;
  virtual void SetParams(const Config &config) = 0;
  virtual void ResetFilter() = 0;
  virtual void ResetPrevValues() = 0;
  virtual T GetPrevOutput() = 0;

private:
  virtual bool CheckFilterValid() = 0;
};

#endif // !FILTER_IFILTER_H
