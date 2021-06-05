#pragma once
#include "pch.h"
#include <iostream>

class AnalysisResult
{
public:
	LPWSTR		name_;
	int			action_ = NONE_;
	double		price_ = 0;
	double		price_ref_ = 0;
	int			takeprofit_pips_ = 0;
	int			stoploss_pips_ = 0;
	double		confidence_ = 0;
	bool		selected_ = false;

	AnalysisResult() {
	}

	AnalysisResult(LPWSTR name, Symbol symbol ,int action, double confidence, int stoploss_pips, int takeprofit_pips) {
		name_ = name;
		action_ = action;
		confidence_ = confidence;
		stoploss_pips_ = stoploss_pips;
		takeprofit_pips_ = takeprofit_pips;

		if (action == BID_) {
			price_ = symbol.ask_;		
			price_ref_ = symbol.bid_;
		}
		else if (action == ASK_) {
			price_ = symbol.bid_;
			price_ref_ = symbol.ask_;
		}
		else {
			price_ = 0;
			price_ref_ = 0;
		}
	}
};

