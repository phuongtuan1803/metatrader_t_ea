// TuanPP1: 2020/08/20
// COMMON.h - Contains declarations of common functions
#pragma once
#include <string>
#include <cstring> 

using namespace std;
extern Symbol symbol_;
extern Account account_;
extern vector<Order> orders_;
extern vector<Order> new_orders_;

/******************************************************************************************
										FOR INIT
*******************************************************************************************/
T_EA_API void init_ontick(const double balance, const double credit, const LPWSTR company, const LPWSTR currency, const double equity,
	const double freemargin, const double freemarginmode, const int leverage, const double margin, const LPWSTR name,
	const int number, const double profit, const LPWSTR server, const int stopoutlevel, const int stopoutmode);

T_EA_API void init_symbol(const LPWSTR name, const double low, const double high, const double time,
	const double bid, const double ask, const double point, const int digits,
	const double spread, const int stoplevel, const double lotsize, const double tickvalue,
	const double ticksize, const double swaplong, const double swapshort, const double starting,
	const double expiration, const int tradeallowed, const double minlot, const double lotstep,
	const double maxlot, const int swaptype, const int profitcalcmode, const int margincalcmode,
	const double margininit, const double marginmaintenance, const double marginhedged, const double marginrequired,
	const int freezelevel, const int closeby_allowed);

/******************************************************************************************
										FOR SYMBOL
*******************************************************************************************/
T_EA_API void symbol_update(const double bid, const double ask);

/******************************************************************************************
										FOR ORDER
*******************************************************************************************/
T_EA_API void order_add(const double closeprice,
	const int closetime,
	const LPWSTR comment,
	const double commission,
	const int expiration,
	const double lots,
	const int magicnumber,
	const double openprice,
	const int opentime,
	const double profit,
	const double stoploss,
	const double swap,
	const LPWSTR symbol,
	const double takeprofit,
	const int ticket,
	const int type
);
T_EA_API void order_action(int action);
T_EA_API void order_add_new(int type, double price, int stoploss_pips, int takeprofit_pips);
T_EA_API void order_process(int trailing_stop_range);
T_EA_API int order_get_action(int ticket);
T_EA_API double order_get_stoploss(int ticket);
T_EA_API double order_get_takeprofit(int ticket);
T_EA_API int order_new_size();

T_EA_API int order_new_get_type(int index);
T_EA_API double order_new_get_lots(int index);
T_EA_API double order_new_get_price(int index);
T_EA_API double order_new_get_stoploss(int index);
T_EA_API double order_new_get_takeprofit(int index);

/******************************************************************************************
										FOR DEBUG
*******************************************************************************************/
T_EA_API void debug_str(const LPWSTR name, const LPWSTR value);
T_EA_API void debug_int(const LPWSTR name, const int value);
T_EA_API void debug_double(const LPWSTR name, const double value);

