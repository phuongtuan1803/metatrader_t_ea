#pragma once
#include <string>
#include <cstring> 
#include <iostream>
#include "pch.h"
#include "Bar.h"
#include "SupportResistanceZone.h"

using namespace std;
class Trend
{
public:
	vector<SupportResistanceZone> supports_;
	vector<SupportResistanceZone> resistances_;
	double k_support_ = 0;
	double k_resistance_ = 0;

	Trend() {

	}
};

extern vector<Trend> trends_[TF_MAX];


/******************************************************************************************
										FOR TRENDS
*******************************************************************************************/
T_EA_API void trend_scan(int timeframe);