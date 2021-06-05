//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2018, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
void orders_get() {
    for(int i = 0; i < OrdersTotal(); i++) { // For market and pending orders
        //If there is the next one and our currency pair
        if((OrderSelect(i, SELECT_BY_POS) == true) && (OrderSymbol() == Symbol())) {
            order_add(
                OrderClosePrice(),
                (int)OrderCloseTime(),
                OrderComment(),
                OrderCommission(),
                (int)OrderExpiration(),
                OrderLots(),
                OrderMagicNumber(),
                OrderOpenPrice(),
                (int)OrderOpenTime(),
                OrderProfit(),
                OrderStopLoss(),
                OrderSwap(),
                OrderSymbol(),
                OrderTakeProfit(),
                OrderTicket(),
                OrderType()
            );
        }
    }
}


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void orders_trade() {
    int action;
    order_process(TRAILING_STOP_RANGE);
    
// FOR OLD ORDER
    for(int i = 0; i < OrdersTotal(); i++) { // For market and pending orders
        //If there is the next one and our currency pair
        if((OrderSelect(i, SELECT_BY_POS) == true) && (OrderSymbol() == Symbol())) {
            action = order_get_action(OrderTicket());
            if(action == DO_CLOSE_) {
                if(OrderType() == OP_BUY) {
                    OrderClose(OrderTicket(), OrderLots(), Ask, 3 );
                } else if(OrderType() == OP_SELL) {
                    OrderClose(OrderTicket(), OrderLots(), Bid, 3 );
                }
            } else if(action == DO_DELETE_) {
                OrderDelete(OrderTicket());
            } else if(action == DO_TRAILING_STOP_) {
				OrderModify(OrderTicket(),OrderOpenPrice(),order_get_stoploss(OrderTicket()),OrderTakeProfit(),0);
            }
        }
    }

// FOR NEW ORDER
	for(int i =0 ;i< order_new_size();i++){
	    	int type = order_new_get_type(i);
	    	double volumn = order_new_get_lots(i);
	    	double price = NormalizeDouble(order_new_get_price(i),Digits);
	    	double sl = NormalizeDouble(order_new_get_stoploss(i),Digits);
	    	double tp = NormalizeDouble(order_new_get_takeprofit(i),Digits);

	    	OrderSend(_Symbol, type, volumn,price, 3, sl, tp);
	}

}
//+------------------------------------------------------------------+
