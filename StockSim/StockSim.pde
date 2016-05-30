import yahoofinance.Stock; //<>//
import yahoofinance.YahooFinance;

import controlP5.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.ArrayList;
import java.util.Calendar;
import java.text.SimpleDateFormat;
import java.util.Map;

ControlP5 cp5;
List<Map<String, Stock>> recentPopularStocks;
String[] popularTickers = {"NDAQ", "^W5000", "^GSPC", "IBM", "GOOG", "FB", "AAPL", "AMZN", "MSFT", "INTC"};
List<Stock> recentQuotes;
int nextPull;
int nextPull2;
List<HistoricalQuote> stockHistQuotes;
String selectedStock;
int graphMode;


void setup() {
  size(1200, 600);
  background(256, 256, 256);
  recentQuotes = new ArrayList<Stock>();
  recentPopularStocks = new ArrayList<Map<String, Stock>>();
  stockHistQuotes = getPastYears("TSLA", 1);
  selectedStock = "NDAQ";
  cp5 = new ControlP5(this);
  setupMostPopularBar(10,40);
  //setupGraphPastRangeButtons(150, 70);
  setupGraphNewHistoryButtons(150, 70);
}


void draw() {
  surface.setTitle(round(frameRate) + " fps");
  background(256, 256, 256);  
  graphEntireList(stockHistQuotes, 800, 400, 100, 550, true);
  livePullPopular(popularTickers, 1000);  // should always be on
  
  //graphRangePopular(recentPopularStocks, selectedStock, 800, 400, 100, 550, (int) cp5.getController("pastRangeNumber").getValue());
  //livePull("NUGT", 1000);

  //graphRange(recentQuotes, 800, 400, 100, 550, (int) cp5.getController("pastRangeNumber").getValue());
}