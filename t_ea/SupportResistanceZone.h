#pragma once
#include <string>
#include <cstring> 
#include <iostream>
#include "pch.h"
#include "Bar.h"

using namespace std;


class SupportResistanceZone
{
public:

	int type_ = SRZ_NONE;
	double price_upper_ = 0.0;
	double price_lower_ = 0.0;
	double confidence_ = 0.0;
	Bar bar_;

	SupportResistanceZone(){
	}

	SupportResistanceZone(Bar bar, int type = SRZ_NONE, double confidence = 0);
};
extern vector<SupportResistanceZone> srz_[TF_MAX];

/******************************************************************************************
										FOR Support Resistance Zone
*******************************************************************************************/

T_EA_API void srz_clear();
T_EA_API void srz_append(int timeframe);
T_EA_API double srz_get_info(int timeframe, int type, int selected_value);