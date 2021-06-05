//+------------------------------------------------------------------+
//|                                                         T_EA.mq4 |
//|                                           Tuan Pham Phuong. 2020 |
//|                                                       tuanio.com |
//+------------------------------------------------------------------+
#property strict
#include "DLLImport.mqh"
#include "Variables.mqh"
#include "Orders.mqh"
#include <Indicators\Oscilators.mqh>
#include <Indicators\Trend.mqh>

CiOsMA CiOsMA_1;
CiRSI CiRSI_1;
CiBands CiBands_1;
CiATR CiATR_1;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
   ObjectsDeleteAll(0);
    if(AccountInfoInteger(ACCOUNT_TRADE_MODE) != ACCOUNT_TRADE_MODE_DEMO)
        return INIT_FAILED;
        
   if(!CiOsMA_1.Create(_Symbol, T_EA_PERIOD, 12, 26, 9, PRICE_CLOSE))
      return INIT_FAILED;
      
   if(!CiRSI_1.Create(_Symbol, T_EA_PERIOD, 14, PRICE_CLOSE))
      return INIT_FAILED; 
      
   if(!CiBands_1.Create(_Symbol, T_EA_PERIOD, 21, 0 , 2.000, PRICE_CLOSE))
      return INIT_FAILED; 
     
   if(!CiATR_1.Create(_Symbol, T_EA_PERIOD, 14))
      return INIT_FAILED; 
      
    ObjectsDeleteAll(0);
    t_ea_initialize();
    for(int i=1000 ;i >= 0;i--){
       api_add_timeframe(1, iTime(_Symbol, T_EA_PERIOD, i), 
                              iOpen(_Symbol, T_EA_PERIOD, i), 
                              iHigh(_Symbol, T_EA_PERIOD, i), 
                              iLow(_Symbol, T_EA_PERIOD, i), 
                              iClose(_Symbol, T_EA_PERIOD, i), 
                              iVolume(_Symbol, T_EA_PERIOD, i));
       t_ea_step();
    }
    return(INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
//---
   t_ea_terminate();
}
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
    MqlTick last_tick = {0};
    SymbolInfoTick(_Symbol, last_tick);
    symbol_get();
    api_add_timeframe(1, iTime(_Symbol, T_EA_PERIOD, 0), 
                           iOpen(_Symbol, T_EA_PERIOD, 1), 
                           iHigh(_Symbol, T_EA_PERIOD, 1), 
                           iLow(_Symbol, T_EA_PERIOD, 1), 
                           iClose(_Symbol, T_EA_PERIOD, 1), 
                           iVolume(_Symbol, T_EA_PERIOD, 1));
    
    CiOsMA_1.Refresh();
    CiRSI_1.Refresh();
    CiBands_1.Refresh();
    CiATR_1.Refresh();
    
    api_add_indicators(CiOsMA_1.Main(1),CiRSI_1.Main(1),CiBands_1.Base(1),CiBands_1.Upper(1),CiBands_1.Lower(1),CiATR_1.Main(1));

    orders_get();
    t_ea_step();    
    orders_trade();
}
//+------------------------------------------------------------------+
