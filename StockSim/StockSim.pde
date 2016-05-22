import yahoofinance.Stock; //<>//
import yahoofinance.YahooFinance;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.ArrayList;
import java.util.Calendar;
import java.text.SimpleDateFormat;

List<Stock> recentQuotes;
int nextPull;
List<HistoricalQuote> stockHistQuotes;
int i = 0;

void setup() {
  size(1400, 700);
  background(256, 256, 256);
  recentQuotes = new ArrayList<Stock>();
  stockHistQuotes = getPastYears("TSLA", 1);
}


void draw() {
  frame.setTitle(round(frameRate) + " fps");
  background(256, 256, 256);
  
  //livePull("AAPL", 1000);
  graphEntireList(stockHistQuotes, 1000, 650, 200, 680,true);
  i++;
  //graphRange(recentQuotes, 1000, 700, 200, 740, 180);
}