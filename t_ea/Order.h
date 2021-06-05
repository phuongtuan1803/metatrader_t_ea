#pragma once
#include <iostream> 
#include <iomanip>
#include <iostream> 
#include "pch.h"
#include "Utils.h"
#include "Config.h"

using namespace std;

class Order
{
public:
	double closeprice_ = 0;
	int closetime_ = 0;
	LPWSTR comment_ = 0;
	double commission_ = 0;
	int expiration_ = 0;
	double lots_ = 0;
	int magicnumber_ = 0;
	double openprice_ = 0;
	int opentime_ = 0;
	double profit_ = 0;
	double stoploss_ = 0;
	double swap_ = 0;
	LPWSTR symbol_ = 0;
	double takeprofit_ = 0;
	int ticket_ = 0;
	int type_ = -1;

	int action_ = DO_NONE_;

	Order() {

	}

	Order(double closeprice, int closetime, LPWSTR comment, double commission,
		int expiration, double lots, int magicnumber, double openprice, int opentime, double profit,
		double stoploss, double swap, LPWSTR symbol, double takeprofit, int ticket, int type
	) {
		closeprice_ = closeprice;
		closetime_ = closetime;
		comment_ = comment;
		commission_ = commission;
		expiration_ = expiration;
		lots_ = lots;
		magicnumber_ = magicnumber_;
		openprice_ = openprice;
		opentime_ = opentime;
		profit_ = profit;
		stoploss_ = stoploss;
		swap_ = swap;
		symbol_ = symbol;
		takeprofit_ = takeprofit;
		ticket_ = ticket;
		type_ = type;
	}

	Order(Symbol symbol, Account account, Config config, int type, double price, int stoploss_pips, int takeprofit_pips) {
		symbol_ = symbol.name_;
		type_ = type;

		if (type == OP_BUY || type == OP_BUYSTOP || type == OP_BUYLIMIT) {
			openprice_ = g_price(symbol, price, symbol.stoplevel_);
			lots_ = g_min_lots(symbol, account, openprice_, config.max_account_per_);
			stoploss_ = g_price(symbol, price, int(symbol.spread_ - stoploss_pips));
			takeprofit_ = g_price(symbol, price, int(symbol.spread_ + takeprofit_pips));
		}
		else if (type == OP_SELL || type == OP_SELLSTOP || type == OP_SELLLIMIT) {
			openprice_ = g_price(symbol, price, -symbol.stoplevel_);
			lots_ = g_min_lots(symbol, account, openprice_, config.max_account_per_);
			stoploss_ = g_price(symbol, price, int(-symbol.spread_ + stoploss_pips));
			takeprofit_ = g_price(symbol, price, int(-symbol.spread_ - takeprofit_pips));
		}
	}

	void print() {
		wchar_t type_str[30];
		switch (type_)
		{
		case OP_BUY:
			wcscpy_s(type_str, L"OP_BUY"); break;
		case OP_SELL:
			wcscpy_s(type_str, L"OP_SELL"); break;
		case OP_BUYLIMIT:
			wcscpy_s(type_str, L"OP_BUYLIMIT"); break;
		case OP_SELLLIMIT:
			wcscpy_s(type_str, L"OP_SELLLIMIT"); break;
		case OP_BUYSTOP:
			wcscpy_s(type_str, L"OP_BUYSTOP"); break;
		case OP_SELLSTOP:
			wcscpy_s(type_str, L"OP_SELLSTOP"); break;
		default:
			wcscpy_s(type_str, L"Invalid Order type"); break;
		}
		wcout << "Symbol " << symbol_
			<< " - " << left << setw(15) << type_str
			<< " * Volumn: " << left << setw(4) << lots_
			<< " * Price: " << left << setw(10) << openprice_
			<< " SL: " << left << setw(10) << stoploss_
			<< " TP: " << left << setw(10) << takeprofit_
			<< " * Profit: " << left << setw(10) << profit_
			<< endl;
	}
};

