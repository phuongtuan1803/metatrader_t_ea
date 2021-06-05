#pragma once
#include "pch.h"
#include "Bar.h"
#include "SupportResistanceZone.h"
#include <vector>
#include <iostream>


vector<SupportResistanceZone> srz_[TF_MAX];

SupportResistanceZone::SupportResistanceZone(Bar bar, int type, double confidence) {
	bar_ = bar;
	confidence_ = confidence;
	type_ = type;
	if (type == SRZ_SUPPORT) {
		price_upper_ = (bar.low_ + bar.lower_price()) / 2;
		price_lower_ = bar.low_;
	}
	else if (type == SRZ_RESISTANCE) {
		price_upper_ = bar.high_;
		price_lower_ = (bar.high_ + bar.upper_price()) / 2;
	}
}
/******************************************************************************************
										FOR Support Resistance Zone
*******************************************************************************************/
void srz_clear() {
	for (int i = 0; i < TF_MAX; i++) {
		srz_[i].clear();
	}
}

void srz_append(int timeframe) {
	int idx = get_timeframe(timeframe);
	if (idx == TF_NONE) {
		return;
	}

	if (bars_[idx].size() < 3) {
		return;
	}
	Bar cur = bars_[idx].back();
	Bar prev_1 = bars_[idx].at(bars_[idx].size() - 2);
	Bar prev_2 = bars_[idx].at(bars_[idx].size() - 3);

	SupportResistanceZone srz;

	if (bar_check_pattern(cur, CANDLES_ENGULFING_BEARLISH)) {
		srz = SupportResistanceZone(prev_1, SRZ_RESISTANCE, 0.1);
	}
	else if (bar_check_pattern(cur, CANDLES_ENGULFING_BULLISH)) {
		srz = SupportResistanceZone(prev_1, SRZ_SUPPORT, 0.1);
	}
	else if (bar_check_pattern(cur, CANDLES_SHOTTING_STAR) || bar_check_pattern(cur, CANDLES_HANGING_MAN)) {
		srz = SupportResistanceZone(prev_1, SRZ_RESISTANCE, 0.3);
	}
	else if (bar_check_pattern(cur, CANDLES_HAMMER) || bar_check_pattern(cur, CANDLES_INVERT_HAMMER)) {
		srz = SupportResistanceZone(prev_1, SRZ_SUPPORT, 0.3);
	}
	else {
		if (cur.is_black() && prev_1.is_white()
			&& prev_1.high_ > cur.high_) {
			srz = SupportResistanceZone(prev_1, SRZ_RESISTANCE, 0);
		}
		else if (cur.is_white() && prev_1.is_black()
			&& prev_1.low_ < cur.low_) {
			srz = SupportResistanceZone(prev_1, SRZ_SUPPORT, 0);
		}
	}
	if (!(srz.price_upper_ == 0 && srz.price_lower_ == 0)) {
		srz_[idx].push_back(srz);
	}	
}

SupportResistanceZone srz_get(int timeframe, int type, double confidence) {
	int idx = get_timeframe(timeframe);
	if (idx == TF_NONE) {
		return SupportResistanceZone();
	}
	if (srz_[idx].empty()) {
		return SupportResistanceZone();
	}

	double cur_price;
	bool is_found = false;
	SupportResistanceZone  most_confidence;
	
	if (type == SRZ_SUPPORT) {
		cur_price = bars_[idx].back().lower_price() + long_value_;
		/* Support */
		for (auto it = srz_[idx].rbegin(); it != srz_[idx].rend(); ++it)
		{
			if ((*it).price_upper_ < cur_price) {
				if ((*it).confidence_ > most_confidence.confidence_) {
					most_confidence = (*it);
				}
				if ((*it).confidence_ >= confidence) {
					return (*it);
				}
				cur_price = (*it).price_lower_;
			}
		}		
		return most_confidence;
	}
	else if (type == SRZ_RESISTANCE) {
		cur_price = bars_[idx].back().upper_price() - long_value_;
		/* Resistance */
		for (auto it = srz_[idx].rbegin(); it != srz_[idx].rend(); ++it)
		{
			if ((*it).price_lower_ > cur_price) {
				if ((*it).confidence_ > most_confidence.confidence_) {
					most_confidence = (*it);
				}
				if ((*it).confidence_ >= confidence) {
					return (*it);
				}
				cur_price = (*it).price_lower_;
			}
		}
		return most_confidence;
	}
	return SupportResistanceZone();
}

double srz_get_info(int timeframe, int type, int selected_value) {

	SupportResistanceZone srz_selected = srz_get(timeframe, type, 0.1);
	switch (selected_value)
	{
	case SRZ_PRICE_UPPER:return srz_selected.price_upper_;
	case SRZ_PRICE_LOWER:return srz_selected.price_lower_;
	case SRZ_CONFIDENCE:return srz_selected.confidence_;
	case SRZ_TIME:return srz_selected.bar_.time_;
	default:
		return -1;
	}
}
