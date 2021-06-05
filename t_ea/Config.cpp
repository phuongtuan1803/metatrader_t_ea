#include "pch.h"
#include "Config.h"

Config config_;

void config_append(double max_account_per)
{
	config_.max_account_per_ = max_account_per;
}
