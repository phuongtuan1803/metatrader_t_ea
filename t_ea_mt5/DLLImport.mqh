//+------------------------------------------------------------------+
//|                                                         t_ea_mt5 |
//|                                           Tuan Pham Phuong. 2020 |
//|                                                       tuanio.com |
//+------------------------------------------------------------------+
#define LPWSTR string
#define T_EA_API

#define int8_T  char
#define uint8_T unsigned char
#define int16_T	short
#define uint16_T	unsigned short
#define int32_T	int
#define uint32_T	unsigned int
#define real32_T	float
#define real64_T	double
#define real_T	double
#define time_T	double
#define boolean_T	unsigned char
#define int_T	int
#define uint_T	unsigned int
#define ulong_T	unsigned long
#define char_T	char
#define uchar_T	unsigned char
#define byte_T	char_T

#import "t_ea.dll"
/*     MAIN API                */
T_EA_API void t_ea_initialize(void);
T_EA_API void t_ea_step(void);
T_EA_API void t_ea_terminate(void);

T_EA_API void api_add_indicators(real_T rtu_iOsMA_1, real_T rtu_iRSI_1, real_T
	rtu_iBands_1_Base, real_T rtu_iBands_1_Upper, real_T rtu_iBands_1_Lower,
	real_T rtu_iATR_1);
T_EA_API void api_add_order(uint32_T rtu_ticket, uint32_T rtu_time_setup, uint8_T
	rtu_type, uint8_T rtu_state, uint32_T rtu_time_expiration, uint32_T
	rtu_time_done, uint32_T rtu_time_setup_msc, uint32_T rtu_time_done_msc,
	uint8_T rtu_type_filling, uint8_T rtu_type_time, uint32_T rtu_magic, uint8_T
	rtu_reason, uint32_T rtu_position_id, uint32_T rtu_position_by_id, real_T
	rtu_volume_initial, real_T rtu_volume_current, real_T rtu_price_open, real_T
	rtu_sl, real_T rtu_tp, real_T rtu_price_current, real_T rtu_price_stoplimit);
T_EA_API void api_add_position(uint32_T rtu_ticket, uint32_T rtu_time, uint32_T
	rtu_time_msc, uint32_T rtu_time_update, uint32_T rtu_time_update_msc, uint8_T
	rtu_type, uint32_T rtu_magic, uint32_T rtu_identifier, uint8_T rtu_reason,
	real_T rtu_volume, real_T rtu_price_open, real_T rtu_sl, real_T rtu_tp, real_T
	rtu_price_current, real_T rtu_swap, real_T rtu_profit);
T_EA_API void api_add_symbol_info_double(real_T rtu_bid, real_T rtu_bidhigh,
	real_T rtu_bidlow, real_T rtu_ask, real_T rtu_askhigh, real_T rtu_asklow,
	real_T rtu_last, real_T rtu_lasthigh, real_T rtu_lastlow, real_T
	rtu_volume_real, real_T rtu_volumehigh_real, real_T rtu_volumelow_real, real_T
	rtu_option_strike, real_T rtu_point, real_T rtu_trade_tick_value, real_T
	rtu_trade_tick_value_profit, real_T rtu_trade_tick_value_loss, real_T
	rtu_trade_tick_size, real_T rtu_trade_contract_size, real_T
	rtu_trade_accrued_interest, real_T rtu_trade_face_value, real_T
	rtu_trade_liquidity_rate, real_T rtu_volume_min, real_T rtu_volume_max, real_T
	rtu_volume_step, real_T rtu_volume_limit, real_T rtu_swap_long, real_T
	rtu_swap_short, real_T rtu_margin_initial, real_T rtu_margin_maintenance,
	real_T rtu_session_volume, real_T rtu_session_turnover, real_T
	rtu_session_interest, real_T rtu_session_buy_orders_volume, real_T
	rtu_session_sell_orders_volume, real_T rtu_session_open, real_T
	rtu_session_close, real_T rtu_session_aw, real_T rtu_session_price_settlement,
	real_T rtu_session_price_limit_min, real_T rtu_session_price_limit_max, real_T
	rtu_margin_hedged, real_T rtu_price_change, real_T rtu_price_volatility,
	real_T rtu_price_theoretical, real_T rtu_price_delta, real_T rtu_price_theta,
	real_T rtu_price_gamma, real_T rtu_price_vega, real_T rtu_price_rho, real_T
	rtu_price_omega, real_T rtu_price_sensitivity);
T_EA_API void api_add_symbol_info_integer(uint32_T rtu_sector, uint32_T
	rtu_industry, uint32_T rtu_custom, uint32_T rtu_background_color, uint32_T
	rtu_chart_mode, uint32_T rtu_exist, uint32_T rtu_select, uint32_T rtu_visible,
	uint32_T rtu_session_deals, uint32_T rtu_session_buy_orders, uint32_T
	rtu_session_sell_orders, uint32_T rtu_volume, uint32_T rtu_volumehigh,
	uint32_T rtu_volumelow, uint32_T rtu_time, uint32_T rtu_time_msc, uint32_T
	rtu_digits, uint32_T rtu_spread_float, uint32_T rtu_spread, uint32_T
	rtu_ticks_bookdepth, uint32_T rtu_trade_calc_mode, uint32_T rtu_trade_mode,
	uint32_T rtu_start_time, uint32_T rtu_expiration_time, uint32_T
	rtu_trade_stops_level, uint32_T rtu_trade_freeze_level, uint32_T
	rtu_trade_exemode, uint32_T rtu_swap_mode, uint32_T rtu_swap_rollover3days,
	uint32_T rtu_margin_hedged_use_leg, uint32_T rtu_expiration_mode, uint32_T
	rtu_filling_mode, uint32_T rtu_order_mode, uint32_T rtu_order_gtc_mode,
	uint32_T rtu_option_mode, uint32_T rtu_option_right);
T_EA_API void api_add_timeframe(real_T rtu_tf_no, uint32_T rtu_time, real_T
	rtu_open, real_T rtu_high, real_T rtu_low, real_T rtu_close, real_T rtu_volume);
T_EA_API void api_clear(void);


/*     SIMULINK API                */
T_EA_API void api_update_position(uint32_T ticket, uint32_T sl, uint32_T tp);
T_EA_API void api_log(int mes);


/*     DLL API                */
#define TYPE_NEW	1
#define TYPE_DEL	2
#define TYPE_UPD	3

#define	INFO_TICKET	1
#define	INFO_TYPE	2
#define	INFO_PRICE	3
#define	INFO_SL		4
#define	INFO_TP		5
#define	INFO_VOL	6
#define	INFO_MAGIC	7
T_EA_API double api_get_order_info(int type_new_delete_update, int type_magic_type_price_sl_tp, int index);

#define CANDLES_TYPE	1
#define CANDLES_FULL	2
#define CANDLES_BODY	3
#define CANDLES_PATTERN	4
T_EA_API int8_T api_get_candles(int type);


#import
//+------------------------------------------------------------------+
