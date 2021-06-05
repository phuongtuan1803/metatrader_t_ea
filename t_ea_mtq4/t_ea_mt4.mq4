//+------------------------------------------------------------------+
//|                                                         T_EA.mq4 |
//|                                           Tuan Pham Phuong. 2020 |
//|                                                       tuanio.com |
//+------------------------------------------------------------------+
#property strict
#include "DLLImport.mqh"
#include "Variables.mqh"
#include "Utils.mqh"
#include "Analysis.mqh"
#include "Orders.mqh"

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit() {
    if(!authentication())      // If the usage conditions..
        return INIT_FAILED;                 //      ..are not met, then exit
        
	config_append(T_EA_MAX_ACCOUNT_PER);
	
    bars_init(T_EA_PERIOD);

    init_symbol(_Symbol,
                MarketInfo(_Symbol, MODE_LOW                    ),
                MarketInfo(_Symbol, MODE_HIGH                   ),
                MarketInfo(_Symbol, MODE_TIME                   ),
                MarketInfo(_Symbol, MODE_BID                    ),
                MarketInfo(_Symbol, MODE_ASK                    ),
                MarketInfo(_Symbol, MODE_POINT                  ),
                (int)MarketInfo(_Symbol, MODE_DIGITS            ),
                MarketInfo(_Symbol, MODE_SPREAD                 ),
                (int)MarketInfo(_Symbol, MODE_STOPLEVEL         ),
                MarketInfo(_Symbol, MODE_LOTSIZE                ),
                MarketInfo(_Symbol, MODE_TICKVALUE              ),
                MarketInfo(_Symbol, MODE_TICKSIZE               ),
                MarketInfo(_Symbol, MODE_SWAPLONG               ),
                MarketInfo(_Symbol, MODE_SWAPSHORT              ),
                MarketInfo(_Symbol, MODE_STARTING               ),
                MarketInfo(_Symbol, MODE_EXPIRATION             ),
                (int)MarketInfo(_Symbol, MODE_TRADEALLOWED      ),
                MarketInfo(_Symbol, MODE_MINLOT                 ),
                MarketInfo(_Symbol, MODE_LOTSTEP                ),
                MarketInfo(_Symbol, MODE_MAXLOT                 ),
                (int)MarketInfo(_Symbol, MODE_SWAPTYPE          ),
                (int)MarketInfo(_Symbol, MODE_PROFITCALCMODE    ),
                (int)MarketInfo(_Symbol, MODE_MARGINCALCMODE    ),
                MarketInfo(_Symbol, MODE_MARGININIT             ),
                MarketInfo(_Symbol, MODE_MARGINMAINTENANCE      ),
                MarketInfo(_Symbol, MODE_MARGINHEDGED           ),
                MarketInfo(_Symbol, MODE_MARGINREQUIRED         ),
                (int)MarketInfo(_Symbol, MODE_FREEZELEVEL       ),
                (int)MarketInfo(_Symbol, MODE_CLOSEBY_ALLOWED   )
               );

    ObjectsDeleteAll(0);
    return(INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason) {
//---

}
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick() {
    init_ontick(AccountBalance(),
                AccountCredit(),
                AccountCompany(),
                AccountCurrency(),
                AccountEquity(),
                AccountFreeMargin(),
                AccountFreeMarginMode(),
                AccountLeverage(),
                AccountMargin(),
                AccountName(),
                AccountNumber(),
                AccountProfit(),
                AccountServer(),
                AccountStopoutLevel(),
                AccountStopoutMode());
    bars_update(T_EA_PERIOD); // update Bar, check SRZ, check trend

    symbol_update(Bid, Ask);

    analysis();
	orders_get();
	orders_trade();
}
//+------------------------------------------------------------------+
