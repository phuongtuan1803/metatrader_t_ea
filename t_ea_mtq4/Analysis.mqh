//+------------------------------------------------------------------+
//|                                               TuanPP_ProX_EA.mq4 |
//|                                           Tuan Pham Phuong. 2020 |
//|                                                       tuanio.com |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void analysis() {
//draw_srz();
    draw_candles();
    Strategy_DoubleCross();
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Strategy_DoubleCross() {
    int St_min = 20;                // Minimum stochastic level
    int St_max = 80;                // Maximum stochastic level
    double Open_Level = 5;          // MACD level for opening (+/-)
    double Close_Level = 4;         // MACD level for closing (+/-)
    string Sym = Symbol();

    double M_0, M_1, S_0, S_1, Rsi_0, Rsi_1;

// Parameters of technical indicators:
    M_0 = iMACD(Sym, T_EA_PERIOD, 12, 26, 9, PRICE_CLOSE, MODE_MAIN, 0); // 0 bar
    M_1 = iMACD(Sym, T_EA_PERIOD, 12, 26, 9, PRICE_CLOSE, MODE_MAIN, 1); // 1 bar
    S_0 = iMACD(Sym, T_EA_PERIOD, 12, 26, 9, PRICE_CLOSE, MODE_SIGNAL, 0); //0 bar
    S_1 = iMACD(Sym, T_EA_PERIOD, 12, 26, 9, PRICE_CLOSE, MODE_SIGNAL, 1); //1 bar

    Rsi_0 = iRSI(Sym, T_EA_PERIOD, 14, PRICE_CLOSE, 0);
    Rsi_1 = iRSI(Sym, T_EA_PERIOD, 14, PRICE_CLOSE, 1);


    int action = NONE_;
    if(M_0 > M_1 &&  Rsi_1 < 30 && Rsi_0 >= 30) {
        Alert("L :", Rsi_1, " - ", Rsi_0);
        order_add_new(OP_BUYSTOP, Ask, MarketInfo(_Symbol, MODE_STOPLEVEL) + 20, 200);
    } else if (M_0 < M_1 &&  Rsi_1 > 70 && Rsi_0 <= 70) {
        Alert("H :", Rsi_1, " - ", Rsi_0);
        order_add_new(OP_SELLSTOP, Bid, MarketInfo(_Symbol, MODE_STOPLEVEL) + 20, 200);
    }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void draw_srz() {
    ResetLastError();
    double support_upper = srz_get_info(T_EA_PERIOD, SRZ_SUPPORT, SRZ_PRICE_UPPER);
    double support_lower = srz_get_info(T_EA_PERIOD, SRZ_SUPPORT, SRZ_PRICE_LOWER);
    double support_confidence = srz_get_info(T_EA_PERIOD, SRZ_SUPPORT, SRZ_CONFIDENCE);
    datetime support_time = (datetime)srz_get_info(T_EA_PERIOD, SRZ_SUPPORT, SRZ_TIME);

    double resistance_upper = srz_get_info(T_EA_PERIOD, SRZ_RESISTANCE, SRZ_PRICE_UPPER);
    double resistance_lower = srz_get_info(T_EA_PERIOD, SRZ_RESISTANCE, SRZ_PRICE_LOWER);
    double resistance_confidence = srz_get_info(T_EA_PERIOD, SRZ_RESISTANCE, SRZ_CONFIDENCE);
    datetime resistance_time = (datetime)srz_get_info(T_EA_PERIOD, SRZ_RESISTANCE, SRZ_TIME);


    string name1, name2;
    name1 = TimeToStr(Time[1]) + ": " + DoubleToStr(support_confidence, 2) + "_support_SRZ";

    if(ObjectCreate(0, name1, OBJ_RECTANGLE, 0, Time[1], support_upper, Time[2], support_lower)) {

        ObjectSetInteger(0, name1, OBJPROP_COLOR, clrYellow);
        ObjectSetInteger(0, name1, OBJPROP_STYLE, STYLE_SOLID);
        ObjectSetInteger(0, name1, OBJPROP_WIDTH, 1);
        ObjectSetInteger(0, name1, OBJPROP_FILL, true);
        ObjectSetInteger(0, name1, OBJPROP_BACK, true);
        ObjectSetInteger(0, name1, OBJPROP_SELECTABLE, false);
        ObjectSetInteger(0, name1, OBJPROP_HIDDEN, false);
        ObjectSetInteger(0, name1, OBJPROP_ZORDER, 0);
        ObjectSetInteger(0, name1, OBJPROP_RAY_RIGHT, false);
    }

    name2 = TimeToStr(Time[1]) + ": " + DoubleToStr(resistance_confidence, 2) + "_resistance_SRZ";

    if(ObjectCreate(0, name2, OBJ_RECTANGLE, 0, Time[1], resistance_upper, Time[2], resistance_lower)) {

        ObjectSetInteger(0, name2, OBJPROP_COLOR, clrAqua);
        ObjectSetInteger(0, name2, OBJPROP_STYLE, STYLE_SOLID);
        ObjectSetInteger(0, name2, OBJPROP_WIDTH, 1);
        ObjectSetInteger(0, name2, OBJPROP_FILL, true);
        ObjectSetInteger(0, name2, OBJPROP_BACK, true);
        ObjectSetInteger(0, name2, OBJPROP_SELECTABLE, false);
        ObjectSetInteger(0, name2, OBJPROP_HIDDEN, false);
        ObjectSetInteger(0, name2, OBJPROP_ZORDER, 0);
        ObjectSetInteger(0, name2, OBJPROP_RAY_RIGHT, false);
    }


}


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void draw_candles() {
    ResetLastError();
    string len_type_str = "", body_len_type_str = "", type_str = "", pattern_str = "", txt = "", txt2 = "";
    string name;

    int pattern = (int)bar_get(T_EA_PERIOD, 1, BAR_PATTERN);
    int type = (int)bar_get(T_EA_PERIOD, 1, BAR_TYPE);
    int length_type = (int)bar_get(T_EA_PERIOD, 1, BAR_LENGHT_TYPE);
    int body_length_type = (int)bar_get(T_EA_PERIOD, 1, BAR_BODY_LENGHT_TYPE);

    switch(length_type) {
    case CANDLES_NONE           :
        len_type_str = "n";
        break;
    case CANDLES_SHORT          :
        len_type_str = "s";
        break;
    case CANDLES_SHORT_MEDIUM   :
        len_type_str = "sm";
        break;
    case CANDLES_MEDIUM         :
        len_type_str = "m";
        break;
    case CANDLES_MEDIUM_LONG    :
        len_type_str = "ml";
        break;
    case CANDLES_LONG           :
        len_type_str = "l";
        break;
    }

    switch(body_length_type) {
    case CANDLES_BODY_DOJI          :
        body_len_type_str += "body-doji";
        break;
    case CANDLES_BODY_HIGH_WAVE     :
        body_len_type_str += "body-highwave";
        break;
    case CANDLES_BODY_NOMAL         :
        body_len_type_str += "body-nomal";
        break;
    case CANDLES_BODY_CLOSE_FULL    :
        body_len_type_str += "body-closefull";
        break;
    case CANDLES_BODY_FULL          :
        body_len_type_str += "body-full";
        break;
    }

    switch(type) {
    case CANDLES_NOMAL              :
        type_str = "nomal";
        break;
    case CANDLES_MARUBOZU           :
        type_str = "marubozu";
        break;
    case CANDLES_CLOSING_MARUBOZU   :
        type_str = "closing_marubozu";
        break;
    case CANDLES_OPENING_MARUBOZU   :
        type_str = "opening_marubozu";
        break;
    case CANDLES_SPINNING_TOP       :
        type_str = "spinning_top";
        break;
    case CANDLES_HIGH_WAVE          :
        type_str = "high_wave ";
        break;
    case CANDLES_LONG_LOWER_SHADOW  :
        type_str = "long_lower_shadow";
        break;
    case CANDLES_LONG_UPPER_SHADOW  :
        type_str = "long_upper_shadow";
        break;
    case CANDLES_LONG_LOWER_SHADOW_NOMAL  :
        type_str = "long_lower_shadow_nomal";
        break;
    case CANDLES_LONG_UPPER_SHADOW_NOMAL  :
        type_str = "long_upper_shadow_nomal";
        break;
    case CANDLES_DOJI               :
        type_str = "doji";
        break;
    case CANDLES_LONG_LEGGED_DOJI   :
        type_str = "long_legged_doji";
        break;
    case CANDLES_DRAGONFLY_DOJI     :
        type_str = "dragonfly_doji";
        break;
    case CANDLES_GRAVESTONE_DOJI    :
        type_str = "gravestone_doji";
        break;
    case CANDLES_FOUR_PRICE_DOJI    :
        type_str = "four_price_doji";
        break;
    }
    if(bool(pattern & BIT(CANDLES_HANGING_MAN))) {
        pattern_str += "hanging_man,";
    }
    if(bool(pattern & BIT(CANDLES_INVERT_HAMMER))) {
        pattern_str += "invert_hammer,";
    }
    if(bool(pattern & BIT(CANDLES_HAMMER))) {
        pattern_str += "hammer,";
    }
    if(bool(pattern & BIT(CANDLES_SHOTTING_STAR))) {
        pattern_str += "shotting_star,";
    }
    if(bool(pattern & BIT(CANDLES_ENGULFING_BULLISH))) {
        pattern_str += "engulfing_bullish,";
    }
    if(bool(pattern & BIT(CANDLES_ENGULFING_BEARLISH))) {
        pattern_str += "engulfing_bearlish,";
    }
    if(bool(pattern & BIT(CANDLES_DARK_CLOUD_COVER))) {
        pattern_str += "dark_cloud_cover,";
    }
    if(bool(pattern & BIT(CANDLES_PIERCING))) {
        pattern_str += "piercing,";
    }
    if(bool(pattern & BIT(CANDLES_COUNTERATTACK_BULLISH))) {
        pattern_str += "counterattack_bullish,";
    }
    if(bool(pattern & BIT(CANDLES_COUNTERATTACK_BEARLISH))) {
        pattern_str += "counterattack_bearlish,";
    }
    if(bool(pattern & BIT(CANDLES_SEPARATING_LINE))) {
        pattern_str += "separating_line,";
    }
    if(bool(pattern & BIT(CANDLES_HARAMI))) {
        pattern_str += "harami,";
    }
    if(bool(pattern & BIT(CANDLES_HARAMI_CROSS))) {
        pattern_str += "harami_cross,";
    }
    if(bool(pattern & BIT(CANDLES_DELIBERATION))) {
        pattern_str += "deliberation,";
    }
    if(bool(pattern & BIT(CANDLES_THREE_WHITE_SOLDIERS))) {
        pattern_str += "three_white_soldiers,";
    }
    if(bool(pattern & BIT(CANDLES_ADVANCE_BLOCK))) {
        pattern_str += "advance_block,";
    }
    if(bool(pattern & BIT(CANDLES_THREE_BLACK_CROWS))) {
        pattern_str += "three_black_crows,";
    }
    if(bool(pattern & BIT(CANDLES_FALLING_THREE_METHODS))) {
        pattern_str += "falling_three_methods,";
    }
    if(bool(pattern & BIT(CANDLES_RISING_THREE_METHODS))) {
        pattern_str += "rising_three_methods,";
    }
    if(bool(pattern & BIT(CANDLES_MORNING_DOJI_STAR))) {
        pattern_str += "morning_doji_star,";
    }
    if(bool(pattern & BIT(CANDLES_EVENING_DOJI_STAR))) {
        pattern_str += "evening_doji_star,";
    }
    if(bool(pattern & BIT(CANDLES_MORNING_STAR))) {
        pattern_str += "morning_star,";
    }
    if(bool(pattern & BIT(CANDLES_EVENING_STAR))) {
        pattern_str += "evening_star,";
    }
    if(bool(pattern & BIT(CANDLES_TRISTAR_BULLISH))) {
        pattern_str += "tristar_bullish,";
    }
    if(bool(pattern & BIT(CANDLES_TRISTAR_BEARLISH))) {
        pattern_str += "tristar_bearlish,";
    }
    if(bool(pattern & BIT(CANDLES_ABANDONED_BABY_BULLISH))) {
        pattern_str += "abandoned_baby_bullish,";
    }
    if(bool(pattern & BIT(CANDLES_ABANDONED_BABY_BEARLISH))) {
        pattern_str += "abandoned_baby_bearlish,";
    }
    if(bool(pattern & BIT(CANDLES_DUMPLING_TOP))) {
        pattern_str += "dumpling_top,";
    }
    if(bool(pattern & BIT(CANDLES_FRYPAN_TOP))) {
        pattern_str += "frypan_top,";
    }
    if(bool(pattern & BIT(CANDLES_THREE_BUDDHA))) {
        pattern_str += "three_buddha,";
    }
    if(bool(pattern & BIT(CANDLES_TOWER))) {
        pattern_str += "tower,";
    }



    name = TimeToStr(Time[0]);
    /*    if(type != CANDLES_NOMAL) {
       txt = type_str + "@" + len_type_str;
           if(ObjectCreate(0, name, OBJ_TEXT, 0, Time[1], High[1] + (WindowPriceMax() - WindowPriceMin()) / 22)) {
               ObjectSetString(0, name, OBJPROP_TEXT, txt );
               ObjectSetString(0, name, OBJPROP_FONT, "Arial");
               ObjectSetInteger(0, name, OBJPROP_FONTSIZE, 10);
               ObjectSetDouble(0, name, OBJPROP_ANGLE, 90);
               ObjectSetInteger(0, name, OBJPROP_ANCHOR, ANCHOR_LEFT);
               ObjectSetInteger(0, name, OBJPROP_COLOR, clrAqua);
               ObjectSetInteger(0, name, OBJPROP_BACK, false);
               ObjectSetInteger(0, name, OBJPROP_SELECTABLE, false);
               ObjectSetInteger(0, name, OBJPROP_SELECTED, false);
               ObjectSetInteger(0, name, OBJPROP_HIDDEN, true);
               ObjectSetInteger(0, name, OBJPROP_ZORDER, 0);
           }
       }
    */
    if(pattern_str != "") {
        txt = pattern_str + "@" + type_str + "@" + len_type_str + "@" + body_len_type_str;
        txt2 = pattern_str;
        Alert(txt)  ;
        if(ObjectCreate(0, name, OBJ_TEXT, 0, Time[1], High[1] + (WindowPriceMax() - WindowPriceMin()) / 50)) {
            ObjectSetString(0, name, OBJPROP_TEXT, txt2 );
            ObjectSetString(0, name, OBJPROP_FONT, "Arial");
            ObjectSetInteger(0, name, OBJPROP_FONTSIZE, 10);
            ObjectSetDouble(0, name, OBJPROP_ANGLE, 0);
            ObjectSetInteger(0, name, OBJPROP_ANCHOR, ANCHOR_LEFT);
            ObjectSetInteger(0, name, OBJPROP_COLOR, clrRed);
            ObjectSetInteger(0, name, OBJPROP_BACK, false);
            ObjectSetInteger(0, name, OBJPROP_SELECTABLE, false);
            ObjectSetInteger(0, name, OBJPROP_SELECTED, false);
            ObjectSetInteger(0, name, OBJPROP_HIDDEN, true);
            ObjectSetInteger(0, name, OBJPROP_ZORDER, 0);
        }
    }
}
//+------------------------------------------------------------------+
