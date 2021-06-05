#pragma once

#define WIN32_LEAN_AND_MEAN             // Exclude rarely-used stuff from Windows headers
// Windows Header Files
#include <windows.h>

#define T_EA_EXPORTS

#ifdef T_EA_EXPORTS
#define T_EA_API extern "C" __declspec(dllexport)
#else
#define T_EA_API extern "C" __declspec(dllimport)
#endif

#define BIT(x)					(1<<x)

/******************************************************************************************
										MTQ4 DEFINE
*******************************************************************************************/
#define OP_BUY 				0	// Buy operation
#define OP_SELL 			1	// Sell operation
#define OP_BUYLIMIT 		2	// Buy limit pending order
#define OP_SELLLIMIT 		3	// Sell limit pending order
#define OP_BUYSTOP 			4	// Buy stop pending order
#define OP_SELLSTOP 		5	// Sell stop pending order

#define PERIOD_CURRENT	0 	
#define PERIOD_M1       1	
#define PERIOD_M5       5	
#define PERIOD_M15      15
#define PERIOD_M30      30
#define PERIOD_H1       60	
#define PERIOD_H4       240
#define PERIOD_D1       1440
#define PERIOD_W1       10080
#define PERIOD_MN1      43200

/******************************************************************************************
										TIMEFRAME INDEX
*******************************************************************************************/
#define TF_NONE		-1
#define TF_CUR		0
#define TF_M1		1
#define TF_M5		2
#define TF_M15		3
#define TF_M30		4
#define TF_H1		5
#define TF_H4		6
#define TF_D1		7
#define TF_W1		8
#define TF_MN		9
#define TF_MAX		10


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
										TREND
*******************************************************************************************/
#define TREND_SIDEWAY				0
#define TREND_UP					1
#define TREND_DOWN					2


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

