//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2018, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
#include <Trade\Trade.mqh>

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void symbol_get()
{
    api_add_symbol_info_integer(
        SymbolInfoInteger(_Symbol, SYMBOL_SECTOR),
        SymbolInfoInteger(_Symbol, SYMBOL_INDUSTRY),
        SymbolInfoInteger(_Symbol, SYMBOL_CUSTOM),
        SymbolInfoInteger(_Symbol, SYMBOL_BACKGROUND_COLOR),
        SymbolInfoInteger(_Symbol, SYMBOL_CHART_MODE),
        SymbolInfoInteger(_Symbol, SYMBOL_EXIST),
        SymbolInfoInteger(_Symbol, SYMBOL_SELECT),
        SymbolInfoInteger(_Symbol, SYMBOL_VISIBLE),
        SymbolInfoInteger(_Symbol, SYMBOL_SESSION_DEALS),
        SymbolInfoInteger(_Symbol, SYMBOL_SESSION_BUY_ORDERS),
        SymbolInfoInteger(_Symbol, SYMBOL_SESSION_SELL_ORDERS),
        SymbolInfoInteger(_Symbol, SYMBOL_VOLUME),
        SymbolInfoInteger(_Symbol, SYMBOL_VOLUMEHIGH),
        SymbolInfoInteger(_Symbol, SYMBOL_VOLUMELOW),
        SymbolInfoInteger(_Symbol, SYMBOL_TIME),
        SymbolInfoInteger(_Symbol, SYMBOL_TIME_MSC),
        SymbolInfoInteger(_Symbol, SYMBOL_DIGITS),
        SymbolInfoInteger(_Symbol, SYMBOL_SPREAD_FLOAT),
        SymbolInfoInteger(_Symbol, SYMBOL_SPREAD),
        SymbolInfoInteger(_Symbol, SYMBOL_TICKS_BOOKDEPTH),
        SymbolInfoInteger(_Symbol, SYMBOL_TRADE_CALC_MODE),
        SymbolInfoInteger(_Symbol, SYMBOL_TRADE_MODE),
        SymbolInfoInteger(_Symbol, SYMBOL_START_TIME),
        SymbolInfoInteger(_Symbol, SYMBOL_EXPIRATION_TIME),
        SymbolInfoInteger(_Symbol, SYMBOL_TRADE_STOPS_LEVEL),
        SymbolInfoInteger(_Symbol, SYMBOL_TRADE_FREEZE_LEVEL),
        SymbolInfoInteger(_Symbol, SYMBOL_TRADE_EXEMODE),
        SymbolInfoInteger(_Symbol, SYMBOL_SWAP_MODE),
        SymbolInfoInteger(_Symbol, SYMBOL_SWAP_ROLLOVER3DAYS),
        SymbolInfoInteger(_Symbol, SYMBOL_MARGIN_HEDGED_USE_LEG),
        SymbolInfoInteger(_Symbol, SYMBOL_EXPIRATION_MODE ),
        SymbolInfoInteger(_Symbol, SYMBOL_FILLING_MODE),
        SymbolInfoInteger(_Symbol, SYMBOL_ORDER_MODE),
        SymbolInfoInteger(_Symbol, SYMBOL_ORDER_GTC_MODE),
        SymbolInfoInteger(_Symbol, SYMBOL_OPTION_MODE),
        SymbolInfoInteger(_Symbol, SYMBOL_OPTION_RIGHT)
    );

    api_add_symbol_info_double(
        SymbolInfoDouble(_Symbol, SYMBOL_BID),
        SymbolInfoDouble(_Symbol, SYMBOL_BIDHIGH),
        SymbolInfoDouble(_Symbol, SYMBOL_BIDLOW),
        SymbolInfoDouble(_Symbol, SYMBOL_ASK),
        SymbolInfoDouble(_Symbol, SYMBOL_ASKHIGH),
        SymbolInfoDouble(_Symbol, SYMBOL_ASKLOW),
        SymbolInfoDouble(_Symbol, SYMBOL_LAST),
        SymbolInfoDouble(_Symbol, SYMBOL_LASTHIGH),
        SymbolInfoDouble(_Symbol, SYMBOL_LASTLOW),
        SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_REAL),
        SymbolInfoDouble(_Symbol, SYMBOL_VOLUMEHIGH_REAL),
        SymbolInfoDouble(_Symbol, SYMBOL_VOLUMELOW_REAL),
        SymbolInfoDouble(_Symbol, SYMBOL_OPTION_STRIKE),
        SymbolInfoDouble(_Symbol, SYMBOL_POINT),
        SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_VALUE),
        SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_VALUE_PROFIT),
        SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_VALUE_LOSS),
        SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_SIZE),
        SymbolInfoDouble(_Symbol, SYMBOL_TRADE_CONTRACT_SIZE),
        SymbolInfoDouble(_Symbol, SYMBOL_TRADE_ACCRUED_INTEREST),
        SymbolInfoDouble(_Symbol, SYMBOL_TRADE_FACE_VALUE),
        SymbolInfoDouble(_Symbol, SYMBOL_TRADE_LIQUIDITY_RATE),
        SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MIN),
        SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MAX),
        SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_STEP),
        SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_LIMIT),
        SymbolInfoDouble(_Symbol, SYMBOL_SWAP_LONG),
        SymbolInfoDouble(_Symbol, SYMBOL_SWAP_SHORT),
        SymbolInfoDouble(_Symbol, SYMBOL_MARGIN_INITIAL),
        SymbolInfoDouble(_Symbol, SYMBOL_MARGIN_MAINTENANCE),
        SymbolInfoDouble(_Symbol, SYMBOL_SESSION_VOLUME),
        SymbolInfoDouble(_Symbol, SYMBOL_SESSION_TURNOVER),
        SymbolInfoDouble(_Symbol, SYMBOL_SESSION_INTEREST),
        SymbolInfoDouble(_Symbol, SYMBOL_SESSION_BUY_ORDERS_VOLUME),
        SymbolInfoDouble(_Symbol, SYMBOL_SESSION_SELL_ORDERS_VOLUME),
        SymbolInfoDouble(_Symbol, SYMBOL_SESSION_OPEN),
        SymbolInfoDouble(_Symbol, SYMBOL_SESSION_CLOSE),
        SymbolInfoDouble(_Symbol, SYMBOL_SESSION_AW),
        SymbolInfoDouble(_Symbol, SYMBOL_SESSION_PRICE_SETTLEMENT),
        SymbolInfoDouble(_Symbol, SYMBOL_SESSION_PRICE_LIMIT_MIN),
        SymbolInfoDouble(_Symbol, SYMBOL_SESSION_PRICE_LIMIT_MAX),
        SymbolInfoDouble(_Symbol, SYMBOL_MARGIN_HEDGED),
        SymbolInfoDouble(_Symbol, SYMBOL_PRICE_CHANGE),
        SymbolInfoDouble(_Symbol, SYMBOL_PRICE_VOLATILITY),
        SymbolInfoDouble(_Symbol, SYMBOL_PRICE_THEORETICAL),
        SymbolInfoDouble(_Symbol, SYMBOL_PRICE_DELTA),
        SymbolInfoDouble(_Symbol, SYMBOL_PRICE_THETA),
        SymbolInfoDouble(_Symbol, SYMBOL_PRICE_GAMMA),
        SymbolInfoDouble(_Symbol, SYMBOL_PRICE_VEGA),
        SymbolInfoDouble(_Symbol, SYMBOL_PRICE_RHO),
        SymbolInfoDouble(_Symbol, SYMBOL_PRICE_OMEGA),
        SymbolInfoDouble(_Symbol, SYMBOL_PRICE_SENSITIVITY)
    );
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void orders_get()
{
    api_clear();
    for(int i = 0; i < OrdersTotal(); i++) { // For market and pending orders
        ResetLastError();
        if(OrderGetTicket(i) != 0) {
            api_add_order(
                OrderGetInteger(ORDER_TICKET),
                OrderGetInteger(ORDER_TIME_SETUP),
                OrderGetInteger(ORDER_TYPE),
                OrderGetInteger(ORDER_STATE),
                OrderGetInteger(ORDER_TIME_EXPIRATION),
                OrderGetInteger(ORDER_TIME_DONE),
                OrderGetInteger(ORDER_TIME_SETUP_MSC),
                OrderGetInteger(ORDER_TIME_DONE_MSC),
                OrderGetInteger(ORDER_TYPE_FILLING),
                OrderGetInteger(ORDER_TYPE_TIME),
                OrderGetInteger(ORDER_MAGIC),
                OrderGetInteger(ORDER_REASON),
                OrderGetInteger(ORDER_POSITION_ID),
                OrderGetInteger(ORDER_POSITION_BY_ID),
                OrderGetDouble(ORDER_VOLUME_INITIAL),
                OrderGetDouble(ORDER_VOLUME_CURRENT),
                OrderGetDouble(ORDER_PRICE_OPEN),
                OrderGetDouble(ORDER_SL),
                OrderGetDouble(ORDER_TP),
                OrderGetDouble(ORDER_PRICE_CURRENT),
                OrderGetDouble(ORDER_PRICE_STOPLIMIT)
            );
        }
    }

    for(int i = 0; i < PositionsTotal(); i++) { // For market and pending orders
        ResetLastError();
        if(PositionGetTicket(i) != 0) {
            api_add_position(
                PositionGetInteger(POSITION_TICKET),
                PositionGetInteger(POSITION_TIME),
                PositionGetInteger(POSITION_TIME_MSC),
                PositionGetInteger(POSITION_TIME_UPDATE),
                PositionGetInteger(POSITION_TIME_UPDATE_MSC),
                PositionGetInteger(POSITION_TYPE),
                PositionGetInteger(POSITION_MAGIC),
                PositionGetInteger(POSITION_IDENTIFIER),
                PositionGetInteger(POSITION_REASON),
                PositionGetDouble(POSITION_VOLUME),
                PositionGetDouble(POSITION_PRICE_OPEN),
                PositionGetDouble(POSITION_SL),
                PositionGetDouble(POSITION_TP),
                PositionGetDouble(POSITION_PRICE_CURRENT),
                PositionGetDouble(POSITION_SWAP),
                PositionGetDouble(POSITION_PROFIT)
            );
        }
    }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void orders_trade()
{
    int i;
    CTrade trade;
// FOR UPDATE ORDER
    i = 0;
    while(api_get_order_info(TYPE_UPD, INFO_TICKET, i) != 0) {
        int ticket = (int)api_get_order_info(TYPE_UPD, INFO_TICKET, i);
        int type = (int)api_get_order_info(TYPE_UPD, INFO_TYPE, i);
        double price = NormalizeDouble(api_get_order_info(TYPE_UPD, INFO_PRICE, i), _Digits);
        double sl = NormalizeDouble(api_get_order_info(TYPE_UPD, INFO_SL, i), _Digits);
        double tp = NormalizeDouble(api_get_order_info(TYPE_UPD, INFO_TP, i), _Digits);
        double volume = NormalizeDouble(api_get_order_info(TYPE_UPD, INFO_VOL, i), _Digits);

        for(int j = PositionsTotal() - 1; j >= 0; j--) {
            if(ticket == PositionGetTicket(j)) {
                //trade.PositionModify(ticket, sl, tp);
                MqlTradeResult result = {0};
                MqlTradeRequest request = {0};
                request.action  = TRADE_ACTION_SLTP; // type of trade operation
                request.position = ticket; // ticket of the position
                request.symbol = _Symbol;   // symbol
                request.sl      = sl;               // Stop Loss of the position
                request.tp      = tp;               // Take Profit of the position
                OrderSend(request, result);
            }
        }
        i++;
    }

// FOR DELETE ORDER
    i = 0;
    while(api_get_order_info(TYPE_DEL, INFO_TICKET, i) != 0) {
        int ticket = (int)api_get_order_info(TYPE_DEL, INFO_TICKET, i);
        int type = (int)api_get_order_info(TYPE_DEL, INFO_TYPE, i);
        double price = NormalizeDouble(api_get_order_info(TYPE_DEL, INFO_PRICE, i), _Digits);
        double sl = NormalizeDouble(api_get_order_info(TYPE_DEL, INFO_SL, i), _Digits);
        double tp = NormalizeDouble(api_get_order_info(TYPE_DEL, INFO_TP, i), _Digits);
        double volume = NormalizeDouble(api_get_order_info(TYPE_DEL, INFO_VOL, i), _Digits);

        MqlTradeResult result = {0};
        MqlTradeRequest request = {0};
        request.action = TRADE_ACTION_REMOVE;       // setting a pending order
        request.symbol = _Symbol;                    // symbol
        request.order = ticket;
        OrderSend(request, result);
        //Print(__FUNCTION__, ": ", result.comment, " reply code ", result.retcode);
        i++;
    }


// FOR NEW ORDER
    i = 0;
    while(api_get_order_info(TYPE_NEW, INFO_PRICE, i) != 0) {
        int type = (int)api_get_order_info(TYPE_NEW, INFO_TYPE, i);
        double price = NormalizeDouble(api_get_order_info(TYPE_NEW, INFO_PRICE, i), _Digits);
        double sl = NormalizeDouble(api_get_order_info(TYPE_NEW, INFO_SL, i), _Digits);
        double tp = NormalizeDouble(api_get_order_info(TYPE_NEW, INFO_TP, i), _Digits);
        double volume = NormalizeDouble(api_get_order_info(TYPE_NEW, INFO_VOL, i), _Digits);
        double magic = NormalizeDouble(api_get_order_info(TYPE_NEW, INFO_MAGIC, i), _Digits);
        MqlTradeResult result = {0};
        MqlTradeRequest request = {0};
        request.action = TRADE_ACTION_PENDING;       // setting a pending order
        request.symbol = _Symbol;                    // symbol
        request.volume = volume;                        // volume in 0.1 lots
        request.sl = sl;                              // Stop Loss is not specified
        request.tp = tp;                              // Take Profit is not specified
        request.type = type;
        request.price = price;
        request.magic = magic;
        request.deviation = 3;
        OrderSend(request, result);
        //Print(__FUNCTION__, ": ", result.comment, " reply code ", result.retcode);
        i++;
    }

}
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
