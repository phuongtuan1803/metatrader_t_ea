//+------------------------------------------------------------------+
bool authentication() {                         // User-defined unction
    if(IsDemo() == true)                // If it is a demo account, then..
        return(true);                    // .. there are no other limitations
    if(AccountCompany() == T_EA_ACCOUNT_COMPANY) // For corporate clients..
        return(true);                    // ..no password is required
    int Key = AccountNumber() * 2 + 1000001; // Calculate the key
    if(T_EA_PASSWORD == Key)                    // If the password is true, then..
        return(true);                    // ..allow the user to work on a real account
//Inform(LOG_UNAUTHORIZED);                         // Message about unauthorized use
    return(false);                      // Exit the user-defined function
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void bars_init(int timeframe) {
    bar_clear();
    double OsMA;
    for(int i = iBars(_Symbol, timeframe); i > 1; i--) {
    	OsMA = iOsMA(_Symbol, timeframe, 4, 12, 4, PRICE_CLOSE, i);
        bar_append(timeframe,(int)iTime(_Symbol,timeframe,i),iOpen(_Symbol,timeframe,i),iClose(_Symbol,timeframe,i),iHigh(_Symbol,timeframe,i),iLow(_Symbol,timeframe,i),iVolume(_Symbol,timeframe,i),OsMA);
    }
}
void bars_update(int timeframe) {
	double OsMA;
	OsMA = iOsMA(_Symbol, timeframe, 4, 12, 4, PRICE_CLOSE, 1);
	bar_append(timeframe,(int)iTime(_Symbol,timeframe,1),iOpen(_Symbol,timeframe,1),iClose(_Symbol,timeframe,1),iHigh(_Symbol,timeframe,1),iLow(_Symbol,timeframe,1),iVolume(_Symbol,timeframe,1),OsMA);
}
