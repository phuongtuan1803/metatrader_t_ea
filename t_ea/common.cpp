// COMMON.cpp : Defines the exported functions for the DLL.
#include "pch.h"
#include "common.h"
#include <utility>
#include <limits.h>
#include <string>
#include <iostream>
#include <vector>
#include <cstring> 

using namespace std;

// DLL internal state variables:
Symbol symbol_;
Account account_;
vector<Order> orders_;
vector<Order> new_orders_;
int action_;

/******************************************************************************************
										FOR INIT
*******************************************************************************************/
void init_ontick(const double balance, const double credit, const LPWSTR company, const LPWSTR currency, const double equity,
	const double freemargin, const double freemarginmode, const int leverage, const double margin, const LPWSTR name,
	const int number, const double profit, const LPWSTR server, const int stopoutlevel, const int stopoutmode) {
	// Clear variable of old tick
	orders_.clear();
	new_orders_.clear();
	// Init account info
	account_ = Account(balance, credit, company, currency, equity,
		freemargin, freemarginmode, leverage, margin, name, number, profit, server, stopoutlevel, stopoutmode);
}

void init_symbol(const LPWSTR name, const double low, const double high, const double time,
	const double bid, const double ask, const double point, const int digits,
	const double spread, const int stoplevel, const double lotsize, const double tickvalue,
	const double ticksize, const double swaplong, const double swapshort, const double starting,
	const double expiration, const int tradeallowed, const double minlot, const double lotstep,
	const double maxlot, const int swaptype, const int profitcalcmode, const int margincalcmode,
	const double margininit, const double marginmaintenance, const double marginhedged, const double marginrequired,
	const int freezelevel, const int closeby_allowed) {
	symbol_ = Symbol(name, low, high, time, bid, ask, point, digits, spread, stoplevel,
		lotsize, tickvalue, ticksize, swaplong, swapshort, starting, expiration, tradeallowed,
		minlot, lotstep, maxlot, swaptype, profitcalcmode, margincalcmode, margininit,
		marginmaintenance, marginhedged, marginrequired, freezelevel, closeby_allowed);
}

/******************************************************************************************
										FOR SYMBOL
*******************************************************************************************/
void symbol_update(const double bid, const double ask) {
	symbol_.update(bid, ask);
}

/******************************************************************************************
										FOR ORDER
*******************************************************************************************/
void order_add(const double closeprice, const int closetime, const LPWSTR comment, const double commission, const int expiration, const double lots, const int magicnumber, const double openprice, const int opentime, const double profit, const double stoploss, const double swap, const LPWSTR symbol, const double takeprofit, const int ticket, const int type) {
	orders_.push_back(Order(closeprice, closetime, comment, commission, expiration, lots, magicnumber, openprice, opentime, profit, stoploss, swap, symbol, takeprofit, ticket, type));
}

void order_action(int action) {
	action_ = action;
}

void order_add_new(int type, double price, int stoploss_pips, int takeprofit_pips){
	if (g_min_lots(symbol_, account_, price, config_.max_account_per_) == 0.0) {
		wcout << "Not enough money " << endl;
	}
	else {
		new_orders_.push_back(Order(symbol_, account_, config_,  type, price, stoploss_pips, takeprofit_pips));
	}
}

void order_process(int trailing_stop_range) {
	/* ----------------------------FOR OLD ORDER ------------------------- */
	for (auto& order : orders_)
	{
		if (action_ == BID_) {
			if (order.type_ == OP_SELL) {
				order.action_ = DO_CLOSE_;
			}
			else if (order.type_ == OP_SELLLIMIT || order.type_ == OP_SELLSTOP) {
				order.action_ = DO_DELETE_;
			}
			else if (order.type_ == OP_BUY) {
				if (order.profit_ > 0 && (order.stoploss_ < symbol_.ask_ - trailing_stop_range * symbol_.point_)) {
					order.action_ = DO_TRAILING_STOP_;
					order.stoploss_ = symbol_.ask_ - trailing_stop_range * symbol_.point_;
				}

			}
		}
		else if (action_ == ASK_) {
			if (order.type_ == OP_BUY) {
				order.action_ = DO_CLOSE_;
			}
			else if (order.type_ == OP_BUYLIMIT || order.type_ == OP_BUYSTOP) {
				order.action_ = DO_DELETE_;
			}
			else if (order.type_ == OP_SELL) {
				if (order.profit_ > 0 && (order.stoploss_ < symbol_.bid_ + trailing_stop_range * symbol_.point_)) {
					order.action_ = DO_TRAILING_STOP_;
					order.stoploss_ = symbol_.bid_ + trailing_stop_range * symbol_.point_;
				}
			}
		}
	}

}

int order_get_action(int ticket) {
	for (auto& order : orders_)
	{
		if (order.ticket_ == ticket) {
			return order.action_;
		}
	}
	return DO_NONE_;
}
double order_get_stoploss(int ticket) {
	for (auto& order : orders_)
	{
		if (order.ticket_ == ticket) {
			return order.stoploss_;
		}
	}
	return 0;
}
double order_get_takeprofit(int ticket) {
	for (auto& order : orders_)
	{
		if (order.ticket_ == ticket) {
			return order.takeprofit_;
		}
	}
	return 0;
}
int order_new_size() {
	return new_orders_.size();
}

int order_new_get_type(int index) {
	return new_orders_[index].type_;
}

double order_new_get_lots(int index) {
	return new_orders_[index].lots_;
}

double order_new_get_price(int index) {
	return new_orders_[index].openprice_;
}

double order_new_get_stoploss(int index) {
	return new_orders_[index].stoploss_;
}

double order_new_get_takeprofit(int index) {
	return new_orders_[index].takeprofit_;
}

/******************************************************************************************
										FOR DEBUG
*******************************************************************************************/

void debug_str(const LPWSTR name, const LPWSTR value) {
	wcout << "DEBUG - " << name << ": " << value << endl;
}

void debug_int(const LPWSTR name, const int value) {
	wcout << "DEBUG - " << name << ": " << value << endl;
}

void debug_double(const LPWSTR name, const double value) {
	wcout << "DEBUG - " << name << ": " << value << endl;
}

