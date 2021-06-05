#pragma once
#include "pch.h"
#include <vector>
#include <set>
#include <numeric>
#include <iostream>
#include <algorithm> 
#include <iterator>
#include "SupportResistanceZone.h"


vector<Bar> bars_[TF_MAX];
set<double> bars_lenght_[TF_MAX];
double short_value_, short_med_value_, med_long_value_, long_value_;

/******************************************************************************************
										BAR METHOD
*******************************************************************************************/
Bar::Bar(int time, double open, double close, double high, double low, double volume, double OsMA) {
	time_ = time;
	open_ = open;
	close_ = close;
	high_ = high;
	low_ = low;
	volume_ = volume;
	OsMA_ = OsMA;
	pattern_ = 0;

	if (OsMA > 0) {
		trend_ = TREND_UP;
	}
	else if (OsMA < 0) {
		trend_ = TREND_DOWN;
	}
	else {
		trend_ = TREND_SIDEWAY;
	}
}

double Bar::upper_price() {
	return max(open_, close_);
}

double Bar::lower_price() {
	return min(open_, close_);
}

double Bar::length_price() {
	return abs(open_ - close_);
}

bool Bar::is_white() {
	return open_ < close_;
}

bool Bar::is_black() {
	return open_ > close_;
}

void Bar::cal_type(double short_value, double short_med_value, double med_long_value, double long_value) {
	double candle_lenght = (high_ - low_);
	double per_body = abs((open_ - close_) / candle_lenght) * 100;
	double per_upper_shadow = abs((high_ - max(open_, close_)) / candle_lenght) * 100;
	double per_lower_shadow = abs((low_ - min(open_, close_)) / candle_lenght) * 100;

	/* **************************  LENGHT TYPE ************************** */
	if (candle_lenght < short_value) {
		length_type_ = CANDLES_SHORT;
	}
	else if (candle_lenght < short_med_value) {
		length_type_ = CANDLES_SHORT_MEDIUM;
	}
	else if (candle_lenght > long_value) {
		length_type_ = CANDLES_LONG;
	}
	else if (candle_lenght > med_long_value) {
		length_type_ = CANDLES_MEDIUM_LONG;
	}
	else {
		length_type_ = CANDLES_MEDIUM;
	}
	/* **************************  BODY LENGHT TYPE ************************** */
	if (per_body < BAR_BODY_RANGE_0) {
		body_length_type_ = CANDLES_BODY_DOJI;
	}
	else if (per_body >= BAR_BODY_RANGE_0 && per_body < BAR_BODY_RANGE_1) {
		body_length_type_ = CANDLES_BODY_HIGH_WAVE;
	}
	else if (per_body >= BAR_BODY_RANGE_1 && per_body < BAR_BODY_RANGE_2) {
		body_length_type_ = CANDLES_BODY_NOMAL;
	}
	else if (per_body >= BAR_BODY_RANGE_2 && per_body < BAR_BODY_RANGE_3) {
		body_length_type_ = CANDLES_BODY_CLOSE_FULL;
	}
	else if (per_body >= BAR_BODY_RANGE_3) {
		body_length_type_ = CANDLES_BODY_FULL;
	}

	/* **************************  CANDLE TYPE ************************** */
	if (candle_lenght == 0) {
		type_ = CANDLES_FOUR_PRICE_DOJI;
	}
	else if (length_type_ == CANDLES_SHORT || length_type_ == CANDLES_SHORT_MEDIUM) {
		if (per_body < BAR_BODY_RANGE_0) {
			type_ = CANDLES_DOJI;
		}
		else {
			type_ = CANDLES_SPINNING_TOP;
		}
	}
	else if (length_type_ == CANDLES_MEDIUM || length_type_ == CANDLES_MEDIUM_LONG || length_type_ == CANDLES_LONG) {
		if (body_length_type_ == CANDLES_BODY_DOJI) {
			if (per_upper_shadow < BAR_SHADOW_MAX) {
				type_ = CANDLES_DRAGONFLY_DOJI;
			}
			else if (per_lower_shadow < BAR_SHADOW_MAX) {
				type_ = CANDLES_GRAVESTONE_DOJI;
			}
			else {
				type_ = CANDLES_LONG_LEGGED_DOJI;
			}
		}
		else if (body_length_type_ == CANDLES_BODY_HIGH_WAVE) {
			if (per_upper_shadow < BAR_SHADOW_MAX) {
				type_ = CANDLES_LONG_LOWER_SHADOW;
			}
			else if (per_lower_shadow < BAR_SHADOW_MAX) {
				type_ = CANDLES_LONG_UPPER_SHADOW;
			}
			else {
				type_ = CANDLES_HIGH_WAVE;
			}
		}
		else if (body_length_type_ == CANDLES_BODY_NOMAL) {
			if (per_upper_shadow < BAR_SHADOW_MAX) {
				type_ = CANDLES_LONG_LOWER_SHADOW_NOMAL;
			}
			else if (per_lower_shadow < BAR_SHADOW_MAX) {
				type_ = CANDLES_LONG_UPPER_SHADOW_NOMAL;
			}
			else {
				type_ = CANDLES_NOMAL;
			}
		}
		else if (body_length_type_ == CANDLES_BODY_CLOSE_FULL) {
			if (per_upper_shadow < BAR_BODY_RANGE_0 && per_lower_shadow < BAR_MARUBOZU_SHADOW_MAX) {
				type_ = CANDLES_CLOSING_MARUBOZU;
			}
			else if (per_upper_shadow < BAR_MARUBOZU_SHADOW_MAX && per_lower_shadow < BAR_BODY_RANGE_0) {
				type_ = CANDLES_OPENING_MARUBOZU;
			}
			else {
				type_ = CANDLES_NOMAL;
			}
		}
		else if (body_length_type_ == CANDLES_BODY_FULL) {
			type_ = CANDLES_MARUBOZU;
		}
	}
}

/******************************************************************************************
										FOR Bar
*******************************************************************************************/
void bar_check_group_pattern_group0(Bar& cur, const vector<Bar> prev_bars) {
	// HANGING_MAN, INVERT_HAMMER
	// HAMMER, SHOTTING_STAR
	Bar first = prev_bars.at(prev_bars.size() - 2);
	Bar second = prev_bars.back();

	// is on Trend
	if (!(second.trend_ == TREND_UP || second.trend_ == TREND_DOWN)) {
		return;
	}

	// bar 1 va bar 3 phai khac mau
	if (!(first.is_white() != cur.is_white())) {
		return;
	}

	if (!(second.type_ == CANDLES_LONG_LOWER_SHADOW
		|| second.type_ == CANDLES_LONG_UPPER_SHADOW
		|| second.type_ == CANDLES_DRAGONFLY_DOJI
		|| second.type_ == CANDLES_GRAVESTONE_DOJI
		)) {
		return;
	}

	// HANGING_MAN, INVERT_HAMMER
	if (second.trend_ == TREND_DOWN) {
		if (first.is_black() && second.upper_price() < first.lower_price()) {
			if (second.type_ == CANDLES_LONG_LOWER_SHADOW || second.type_ == CANDLES_DRAGONFLY_DOJI) {
				cur.pattern_ += BIT(CANDLES_HAMMER);
			}
			else if (second.type_ == CANDLES_LONG_UPPER_SHADOW || second.type_ == CANDLES_GRAVESTONE_DOJI) {
				cur.pattern_ += BIT(CANDLES_INVERT_HAMMER);
			}
		}
	}

	// HAMMER, SHOTTING_STAR
	if (second.trend_ == TREND_UP) {
		if (first.is_white() && second.lower_price() > first.upper_price()) {
			if (second.type_ == CANDLES_LONG_LOWER_SHADOW || second.type_ == CANDLES_DRAGONFLY_DOJI) {
				cur.pattern_ += BIT(CANDLES_HANGING_MAN);
			}
			else if (second.type_ == CANDLES_LONG_UPPER_SHADOW || second.type_ == CANDLES_GRAVESTONE_DOJI) {
				cur.pattern_ += BIT(CANDLES_SHOTTING_STAR);
			}
		}
	}
}
void bar_check_group_pattern_group1(Bar& cur, const vector<Bar> prev_bars) {
	//  ENGULFING_BULLISH, ENGULFING_BEARLISH
	//	PIERCING, DARK_CLOUD_COVER
	//	COUNTERATTACK_BULLISH, COUNTERATTACK_BEARLISH
	Bar first = prev_bars.at(prev_bars.size() - 2);
	Bar second = prev_bars.back();

	// is on Trend
	if (!(second.trend_ == TREND_UP || second.trend_ == TREND_DOWN)) {
		return;
	}

	// bar 1 va bar 2 phai khac mau, bar 2 va bar 3 cung mau
	if (!(first.is_white() != second.is_white() && second.is_white() == cur.is_white())) {
		return;
	}

	// bar 1 va bar 2 phai hon MEDIUM va khong phai doji
	if (!(first.length_type_ >= CANDLES_MEDIUM && second.length_type_ >= CANDLES_MEDIUM
		&& first.body_length_type_ >= CANDLES_BODY_NOMAL && second.body_length_type_ >= CANDLES_BODY_NOMAL)) {
		return;
	}
	double delta_bar = first.length_price() * BAR_ENGULFING_DELTA / 100;

	// ENGULFING_BULLISH, PIERCING, COUNTERATTACK_BULLISH
	if (second.trend_ == TREND_DOWN) {
		// bar 2 phai thap hon bar 1	
		if (!(second.lower_price() + delta_bar < first.lower_price())) {
			return;
		}

		// Confirm bar
		if (cur.is_white() && cur.length_type_ >= CANDLES_SHORT_MEDIUM) {
			if (second.upper_price() > first.upper_price()) {
				cur.pattern_ += BIT(CANDLES_ENGULFING_BULLISH);
			}
			else if (second.upper_price() > first.lower_price() + first.length_price() * 0.5) {
				cur.pattern_ += BIT(CANDLES_PIERCING);
			}
			else if (second.upper_price() > first.lower_price()) {
				// REST but not create window
				cur.pattern_ += BIT(CANDLES_COUNTERATTACK_BULLISH);
			}
		}
	}

	// ENGULFING_BEARLISH, DARK_CLOUD_COVER, COUNTERATTACK_BEARLISH
	if (second.trend_ == TREND_UP) {
		// bar 2 phai cao hon bar 1
		if (!(second.upper_price() - delta_bar > first.upper_price())) {
			return;
		}

		// Confirm bar
		if (cur.is_black() && cur.length_type_ >= CANDLES_SHORT_MEDIUM) {
			if (second.lower_price() < first.lower_price()) {
				cur.pattern_ += BIT(CANDLES_ENGULFING_BEARLISH);
			}
			else if (second.lower_price() < first.upper_price() - first.length_price() * 0.5) {
				cur.pattern_ += BIT(CANDLES_DARK_CLOUD_COVER);
			}
			else if (second.lower_price() < first.upper_price()) {
				// REST but not create window
				cur.pattern_ += BIT(CANDLES_COUNTERATTACK_BEARLISH);
			}
		}
	}
}
void bar_check_group_pattern_group2(Bar& cur, const vector<Bar> prev_bars) {
	// MORNING_DOJI_STAR, EVENING_DOJI_STAR
	// MORNING_STAR, EVENING_STAR
	// TRISTAR_BULLISH, TRISTAR_BEARLISH
	// ABANDONED_BABY_BULLISH, ABANDONED_BABY_BEARLISH

	Bar first = prev_bars.at(prev_bars.size() - 2);
	Bar second = prev_bars.back();

	// is on Trend
	if (!(second.trend_ == TREND_UP || second.trend_ == TREND_DOWN)) {
		return;
	}

	// TRISTAR_BULLISH
	if (second.trend_ == TREND_DOWN) {
		if (first.body_length_type_ == CANDLES_BODY_DOJI
			&& second.body_length_type_ == CANDLES_BODY_DOJI
			&& cur.body_length_type_ == CANDLES_BODY_DOJI) {
			cur.pattern_ += BIT(CANDLES_TRISTAR_BULLISH);
			return;
		}
	}

	// TRISTAR_BEARLISH
	if (second.trend_ == TREND_UP) {
		if (first.body_length_type_ == CANDLES_BODY_DOJI
			&& second.body_length_type_ == CANDLES_BODY_DOJI
			&& cur.body_length_type_ == CANDLES_BODY_DOJI) {
			cur.pattern_ += BIT(CANDLES_TRISTAR_BEARLISH);
			return;
		}
	}
	// bar 1 va bar 3 phai khac mau
	if (!(first.is_white() != cur.is_white())) {
		return;
	}

	// bar 1 va bar 3 phai hon MEDIUM va khong phai doji, bar 2 phai nho
	if (!(first.length_type_ >= CANDLES_MEDIUM && cur.length_type_ >= CANDLES_MEDIUM
		&& first.body_length_type_ >= CANDLES_BODY_NOMAL && cur.body_length_type_ >= CANDLES_BODY_NOMAL
		&& second.length_type_ == CANDLES_SHORT)) {
		return;
	}

	// MORNING_DOJI_STAR, MORNING_STAR, TRISTAR_BULLISH, ABANDONED_BABY_BULLISH
	if (second.trend_ == TREND_DOWN) {
		if (first.is_black() && second.upper_price() < first.lower_price()) {
			double do_lan_sau = (cur.upper_price() - first.lower_price()) / first.length_price() * 100;
			if (do_lan_sau > 50) {
				if (second.body_length_type_ == CANDLES_BODY_DOJI) {
					if (second.high_ < first.low_ && second.high_ < cur.low_) {
						cur.pattern_ += BIT(CANDLES_ABANDONED_BABY_BULLISH);
					}
					else {
						cur.pattern_ += BIT(CANDLES_MORNING_DOJI_STAR);
					}
				}
				else {
					cur.pattern_ += BIT(CANDLES_MORNING_STAR);
				}
			}
		}
	}

	// EVENING_DOJI_STAR, EVENING_STAR, TRISTAR_BEARLISH, ABANDONED_BABY_BEARLISH
	if (second.trend_ == TREND_UP) {
		if (first.is_white() && second.lower_price() > first.upper_price()) {
			double do_lan_sau = -(cur.lower_price() - first.upper_price()) / first.length_price() * 100;
			if (do_lan_sau > 50) {
				if (second.body_length_type_ == CANDLES_BODY_DOJI) {
					if (second.low_ > first.high_ && second.low_ > cur.high_) {
						cur.pattern_ += BIT(CANDLES_ABANDONED_BABY_BEARLISH);
					}
					else {
						cur.pattern_ += BIT(CANDLES_EVENING_DOJI_STAR);
					}
				}
				else {
					cur.pattern_ += BIT(CANDLES_EVENING_STAR);
				}
			}
		}
	}
}

void bar_clear() {
	for (int i = 0; i < TF_MAX; i++) {
		bars_[i].clear();
	}
}

void bar_append(int timeframe, int time, double open, double close, double high, double low, double volume, double OsMA) {
	int idx = get_timeframe(timeframe);
	if (idx == TF_NONE) {
		return;
	}
	Bar new_bar(time, open, close, high, low, volume, OsMA);

	/* Append only if time is valid */
	if (!bars_[idx].empty()) {
		if (time <= bars_[idx].back().time_) {
			return;
		}
	}

	/* Append and Do not check pattern if Bar size < 4 */
	if (bars_[idx].size() < 5) {
		bars_[idx].push_back(new_bar);
		bars_lenght_[idx].insert(new_bar.high_ - new_bar.low_);
		return;
	}

	/* Calulate bar length and type  */

	int number_short = int(bars_lenght_[idx].size() * BAR_SHORT_RATE);
	int number_short_med = int(bars_lenght_[idx].size() * BAR_SHORT_MEDIUM_RATE);
	int number_med_long = int(bars_lenght_[idx].size() * BAR_MEDIUM_LONG_RATE);
	int number_long = int(bars_lenght_[idx].size() * BAR_LONG_RATE);

	vector<double> v(bars_lenght_[idx].begin(), bars_lenght_[idx].end());
	sort(v.begin(), v.end());

	short_value_ = v.at(number_short);
	short_med_value_ = v.at(number_short);
	med_long_value_ = v.at(number_short);
	long_value_ = v.at(number_short);

	new_bar.cal_type(v.at(number_short), v.at(number_short_med), v.at(number_med_long), v.at(number_long));

	/* Append and check pattern  */
	bar_check_group_pattern_group0(new_bar, bars_[idx]);
	bar_check_group_pattern_group1(new_bar, bars_[idx]);
	bar_check_group_pattern_group2(new_bar, bars_[idx]);

	bars_[idx].push_back(new_bar);

	/* Update bar length for check spinning top bar  */
	bars_lenght_[idx].insert(new_bar.high_ - new_bar.low_);

	/* SRZ  */
	srz_append(timeframe);
}

bool bar_check_pattern(const Bar bar, int pattern) {
	return bar.pattern_ & BIT(pattern);
}

double bar_get(int timeframe, int index, int type)
{
	int idx = get_timeframe(timeframe);
	if (idx == TF_NONE) {
		return 0.0;
	}
	vector<Bar>& bars = bars_[idx];
	Bar& bar = bars.at(bars.size() - index);

	if (type == BAR_PATTERN) {
		return (double)bar.pattern_;
	}
	else if (type == BAR_BODY_LENGHT_TYPE) {
		return bar.body_length_type_;
	}
	else if (type == BAR_LENGHT_TYPE) {
		return bar.length_type_;
	}
	else if (type == BAR_TYPE) {
		return bar.type_;
	}
	else {
		return 0.0;
	}
}
