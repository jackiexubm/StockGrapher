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

void setup() {
  size(1400, 800);
  background(256, 256, 256);
  recentQuotes = new ArrayList<Stock>();
  List<HistoricalQuote> stockHistQuotes = getPastYears("TSLA", 5);
  graphEntireList(stockHistQuotes, 1000, 700, 200, 740);
}


void draw() {
  background(256, 256, 256);
  livePull("AAPL", 1000);

  graphRange(recentQuotes, 1000, 700, 200, 740, 180);
}