#pragma once
#include <string>
using namespace std;

class Symbol
{
public:
	PWSTR			name_;
	double			low_ = 0;
	double			high_ = 0;
	double			time_ = 0;
	double			bid_ = 0;
	double			ask_ = 0;
	double			point_ = 0;
	int				digits_ = 0;
	double			spread_ = 0;
	int				stoplevel_ = 0;
	double			lotsize_ = 0;
	double			tickvalue_ = 0;
	double			ticksize_ = 0;
	double			swaplong_ = 0;
	double			swapshort_ = 0;
	double			starting_ = 0;
	double			expiration_ = 0;
	double			tradeallowed_ = 0;
	double			minlot_ = 0;
	double			lotstep_ = 0;
	double			maxlot_ = 0;;
	double			swaptype_ = 0;;
	double			profitcalcmode_ = 0;;
	double			margincalcmode_ = 0;;
	double			margininit_ = 0;;
	double			marginmaintenance_ = 0;;
	double			marginhedged_ = 0;;
	double			marginrequired_ = 0;;
	double			freezelevel_ = 0;;
	double			closeby_allowed_ = 0;;

	Symbol() {

	}

	Symbol(const LPWSTR name,
		const double low,
		const double high,
		const double time,
		const double bid,
		const double ask,
		const double point,
		const int digits,
		const double spread,
		const int stoplevel,
		const double lotsize,
		const double tickvalue,
		const double ticksize,
		const double swaplong,
		const double swapshort,
		const double starting,
		const double expiration,
		const int tradeallowed,
		const double minlot,
		const double lotstep,
		const double maxlot,
		const int swaptype,
		const int profitcalcmode,
		const int margincalcmode,
		const double margininit,
		const double marginmaintenance,
		const double marginhedged,
		const double marginrequired,
		const int freezelevel,
		const int closeby_allowed )
	{
		name_ = name;
		low_ = low;
		high_ = high;
		time_ = time;
		bid_ = bid;
		ask_ = ask;
		point_ = point;
		digits_ = digits;
		spread_ = spread;
		stoplevel_ = stoplevel;
		lotsize_ = lotsize;
		tickvalue_ = tickvalue;
		ticksize_ = ticksize;
		swaplong_ = swaplong;
		swapshort_ = swapshort;
		starting_ = starting;
		expiration_ = expiration;
		tradeallowed_ = tradeallowed;
		minlot_ = minlot;
		lotstep_ = lotstep;
		maxlot_ = maxlot;
		swaptype_ = swaptype;
		profitcalcmode_ = profitcalcmode;
		margincalcmode_ = margincalcmode;
		margininit_ = margininit;
		marginmaintenance_ = marginmaintenance;
		marginhedged_ = marginhedged;
		marginrequired_ = marginrequired;
		freezelevel_ = freezelevel;
		closeby_allowed_ = closeby_allowed;
	}
	void update(const double bid, const double ask) {
		bid_ = bid;
		ask_ = ask;
	}
};

