#include "pch.h"
#include "Trend.h"
#include <vector>
#include <iostream>

vector<Trend> trends_[TF_MAX];

/******************************************************************************************
										FOR TRENDS
*******************************************************************************************/
void trend_clear() {
	for (int i = 0; i < TF_MAX; i++) {
		trends_[i].clear();
	}
}

void trend_scan(int timeframe) {
	int idx = get_timeframe(timeframe);
	if (idx == TF_NONE) {
		return;
	}
	trends_[idx].clear();
	
	if (srz_[idx].size() < 5) {
		return;
	}
	
	int i = srz_[idx].size() - 1;
	double k_resistance, k_support;

	while (i > 0) {
		Trend trend;
		SupportResistanceZone v1, v2, v3, v4;

		if (srz_[idx].at(i).type_ == SRZ_RESISTANCE) {
			v1 = srz_[idx].at(i);		// res
			v2 = srz_[idx].at(i-1);		// sup
			v3 = srz_[idx].at(i-2);		// res
			v4 = srz_[idx].at(i-3);		// sup
		}
		else {
			v1 = srz_[idx].at(i - 1);
			v2 = srz_[idx].at(i);
			v3 = srz_[idx].at(i - 3);
			v4 = srz_[idx].at(i - 2);
		}

		double time1 = v1.bar_.time_;
		double time2 = v2.bar_.time_;
		double time3 = v3.bar_.time_;
		double time4 = v4.bar_.time_;

		k_resistance = (v1.price_upper_ + v3.price_upper_) / (time1 - time3);
		k_support = (v2.price_lower_ + v4.price_lower_) / (time2 - time4);

		if (k_resistance < 0.1 || k_support < 0.1) {
			k_resistance = 0;
			k_support = 0;
		}

		trend.resistances_.push_back(v1);
		trend.resistances_.push_back(v3);

		trend.supports_.push_back(v2);
		trend.supports_.push_back(v4);

		trend.k_resistance_ = k_resistance;
		trend.k_support_ = k_support;
	}


}