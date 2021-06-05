#define LPWSTR string
#define T_EA_API 
#define BIT(x)					(1<<x)
/******************************************************************************************
										JAPANESE CANDLESTICK
*******************************************************************************************/

/*	LENGTH											*/
#define CANDLES_NONE     							0

#define CANDLES_SHORT     							1
#define CANDLES_SHORT_MEDIUM						2
#define CANDLES_MEDIUM								3
#define CANDLES_MEDIUM_LONG     					4
#define CANDLES_LONG     							5

#define CANDLES_BODY_DOJI							1
#define CANDLES_BODY_HIGH_WAVE						2
#define CANDLES_BODY_NOMAL							3
#define CANDLES_BODY_CLOSE_FULL						4
#define CANDLES_BODY_FULL							5

#define BAR_SHORT_RATE								0.15
#define BAR_SHORT_MEDIUM_RATE						0.3
#define BAR_MEDIUM_LONG_RATE						0.7
#define BAR_LONG_RATE								0.85

#define BAR_BODY_RANGE_0							3
#define BAR_BODY_RANGE_1							10
#define BAR_BODY_RANGE_2							75
#define BAR_BODY_RANGE_3							97

/*	FOR API EXPORT									*/
#define BAR_PATTERN									0
#define BAR_LENGHT_TYPE								1
#define BAR_BODY_LENGHT_TYPE						2
#define BAR_TYPE									3

/*	BAR CONFIG										*/

#define BAR_MARUBOZU_SHADOW_MAX						25
#define BAR_SHADOW_MAX								25

#define BAR_ENGULFING_DELTA							3

/*	BAR	TYPE										*/
#define	CANDLES_NOMAL								0 
#define CANDLES_MARUBOZU							1 
#define CANDLES_CLOSING_MARUBOZU					2 
#define CANDLES_OPENING_MARUBOZU    				3 
#define CANDLES_SPINNING_TOP        				4 
#define CANDLES_HIGH_WAVE        					5 
#define CANDLES_LONG_LOWER_SHADOW   				6 
#define CANDLES_LONG_UPPER_SHADOW   				7 
#define CANDLES_LONG_LOWER_SHADOW_NOMAL 			8
#define CANDLES_LONG_UPPER_SHADOW_NOMAL				9 
#define CANDLES_DOJI                				10 
#define CANDLES_LONG_LEGGED_DOJI                	11
#define CANDLES_DRAGONFLY_DOJI      				12
#define CANDLES_GRAVESTONE_DOJI     				13
#define CANDLES_FOUR_PRICE_DOJI     				14

/*	BAR	PATTERN									*/
#define CANDLES_HANGING_MAN 0 // group 0
#define CANDLES_INVERT_HAMMER 1 // group 0
#define CANDLES_HAMMER 2 // group 0
#define CANDLES_SHOTTING_STAR 3 // group 0
#define CANDLES_ENGULFING_BULLISH 4 // group 1
#define CANDLES_ENGULFING_BEARLISH 5 // group 1
#define CANDLES_DARK_CLOUD_COVER 6 // group 1
#define CANDLES_PIERCING 7 // group 1
#define CANDLES_COUNTERATTACK_BULLISH 8 // group 1
#define CANDLES_COUNTERATTACK_BEARLISH 9 // group 1
#define CANDLES_SEPARATING_LINE 10 // group 1
#define CANDLES_HARAMI 11 // group 1
#define CANDLES_HARAMI_CROSS 12 // group 1
#define CANDLES_DELIBERATION 13 // group 3
#define CANDLES_THREE_WHITE_SOLDIERS 14 // group 3
#define CANDLES_ADVANCE_BLOCK 15 // group 3
#define CANDLES_THREE_BLACK_CROWS 16 // group 3
#define CANDLES_FALLING_THREE_METHODS 17 // 3 bar
#define CANDLES_RISING_THREE_METHODS 18 // 3 bar
#define CANDLES_MORNING_DOJI_STAR 19 // group 2
#define CANDLES_EVENING_DOJI_STAR 20 // group 2
#define CANDLES_MORNING_STAR 21 // group 2
#define CANDLES_EVENING_STAR 22 // group 2
#define CANDLES_TRISTAR_BULLISH 23 // group 2
#define CANDLES_TRISTAR_BEARLISH 24 // group 2
#define CANDLES_ABANDONED_BABY_BULLISH 25 // group 2
#define CANDLES_ABANDONED_BABY_BEARLISH 26 // group 2
#define CANDLES_DUMPLING_TOP 27 // MULT
#define CANDLES_FRYPAN_TOP 28 // MULT
#define CANDLES_THREE_BUDDHA 29 // MULT
#define CANDLES_TOWER 30 // MULT
#define CANDLES_MAX 31 // ARRAY SIZE


/******************************************************************************************
										SUPPORT RESISTANCE ZONE
*******************************************************************************************/
#define SRZ_NONE					0
#define SRZ_SUPPORT					1
#define SRZ_RESISTANCE				2

#define SRZ_PRICE_UPPER		1
#define SRZ_PRICE_LOWER		2
#define SRZ_CONFIDENCE		3
#define SRZ_TIME			4

/******************************************************************************************
										ORTHER
*******************************************************************************************/
#define NONE_				0
#define BID_				1
#define ASK_				2

#define DO_NONE_			0
#define DO_CLOSE_			1
#define DO_DELETE_			2
#define DO_TRAILING_STOP_	3


#import "t_ea.dll"

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


/******************************************************************************************
										FOR Support Resistance Zone
*******************************************************************************************/

T_EA_API void srz_clear();
T_EA_API void srz_append(int timeframe);
T_EA_API double srz_get_info(int timeframe, int type, int selected_value);


/******************************************************************************************
										FOR BARS
*******************************************************************************************/

T_EA_API void bar_clear();
T_EA_API void bar_append(int timeframe, int time, double open, double close, double high, double low, double volume, double OsMA);
T_EA_API double bar_get(int timeframe, int index, int type);

/******************************************************************************************
										FOR Config
*******************************************************************************************/
T_EA_API void config_append(double max_account_per);
#import