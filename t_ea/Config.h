#pragma once
#include <iostream> 

class Config
{
public:
	double max_account_per_ = 0;

	Config() {

	}
};

extern Config config_;

T_EA_API void config_append(double max_account_per);