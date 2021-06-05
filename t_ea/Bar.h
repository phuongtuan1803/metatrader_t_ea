#pragma once
#include <string>
#include <cstring> 
#include <iostream>
#include <vector>

using namespace std;
class Bar
{
public:
	int time_ = 0;
	double open_ = 0, close_ = 0, high_ = 0, low_ = 0, volume_ = 0;
	double OsMA_ = 0;
	int trend_ = 0;

	int length_type_ = CANDLES_NONE;
	int body_length_type_ = CANDLES_NONE;
	int type_ = CANDLES_NONE;

	int pattern_ : CANDLES_MAX;

	Bar() {

	}

	Bar(int time, double open, double close, double high, double low, double volume, double OsMA);
	
	double upper_price();
	double lower_price();
	double length_price();
	bool is_white();
	bool is_black();

	void cal_type(double short_value, double short_med_value, double med_long_value, double long_value);
};

extern vector<Bar> bars_[TF_MAX];
extern double short_value_, short_med_value_, med_long_value_, long_value_;
/******************************************************************************************
										FOR BARS
*******************************************************************************************/

T_EA_API void bar_clear();
T_EA_API void bar_append(int timeframe, int time, double open, double close, double high, double low, double volume, double OsMA);
T_EA_API double bar_get(int timeframe, int index, int type);

bool bar_check_pattern(const Bar bar, int pattern);