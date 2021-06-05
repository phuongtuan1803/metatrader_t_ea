
#include "pch.h"
#include "Utils.h"
#include "Symbol.h"
#include "Account.h"
#include <utility>
#include <limits.h>
#include <string>
#include <iostream>
#include <vector>
#include <cstring> 

using namespace std;

double g_price(Symbol symbol, double init_price, int pips) {
	//return (int)((init_price + symbol.point_ * pips) / symbol.point_) * symbol.point_;
	return init_price + symbol.point_* pips;
}

int g_point(Symbol symbol, double init_price, double end_price) {
	return (int)(round((end_price - init_price) / symbol.point_));
}

double g_min_lots(Symbol symbol, Account account, double price, double max_account_per) {
	double max_lots = (floor(account.freemargin_ / symbol.marginrequired_ / symbol.lotstep_))* symbol.lotstep_;
	if (max_lots < symbol.minlot_) {
		return 0.0;
	}
	
	double volume = max_lots * max_account_per/100;					// Min volumn
	volume = floor(volume / symbol.lotstep_) * symbol.lotstep_;		// Convert according Lot Step
	volume = volume > symbol.minlot_? volume:symbol.minlot_;		// Compare with Min lot
	return volume;
}

int get_timeframe(int timeframe) {
	switch (timeframe)
	{
		case PERIOD_CURRENT: return TF_CUR;
		case PERIOD_M1: return TF_M1;
		case PERIOD_M5: return TF_M5;
		case PERIOD_M15: return TF_M15;
		case PERIOD_M30: return TF_M30;
		case PERIOD_H1: return TF_H1;
		case PERIOD_H4: return TF_H4;
		case PERIOD_D1: return TF_W1;
		case PERIOD_W1: return TF_MN;
		case PERIOD_MN1: return TF_MN;
		default: return TF_NONE;
	}
}
