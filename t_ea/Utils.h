#pragma once
using namespace std;
#include "pch.h"

T_EA_API double g_price(Symbol symbol, double init_price, int pips);
T_EA_API int g_point(Symbol symbol, double init_price, double end_price);

T_EA_API double g_min_lots(Symbol symbol, Account account, double price, double max_account_per);
T_EA_API int get_timeframe(int timeframe);