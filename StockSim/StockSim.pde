import yahoofinance.Stock;
import yahoofinance.YahooFinance;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.ArrayList;
import java.util.Calendar;

void setup() {
  size(1400, 800);
  background(256, 256, 256);

  List<HistoricalQuote> stockHistQuotes = getPastYear("AAPL");
  for (int i = 0; i < stockHistQuotes.size() - 1; i ++) {
    line((float) i * 2, 500 - (stockHistQuotes.get(i).getClose().floatValue() * 5 - 300), (float) i * 2 + 2, 500 - (stockHistQuotes.get(i + 1).getClose().floatValue() * 5 - 300));
  }
  
  graphWholeList(stockHistQuotes, 400,400,5,500);
}


void draw() {
}

void graphWholeList(List<HistoricalQuote> data, float width, float height, float originX, float originY){
  line(originX,originY,originX, originY - height);
  line(originX,originY,originX + width, originY);
  
}

float[] getMinMax(List<HistoricalQuote> data){
  float[] ret = new float[2];
  ret[0] = data.get(0).getClose().floatValue();
  ret[1] = data.get(0).getClose().floatValue();
  for(int i = 0; i < data.size(); i ++) {
    float value = data.get(i).getClose().floatValue();
    if(value < ret[0]){
      ret[0] = value;
    }else if(value > ret[1]){
      ret[1] = value;
    }
  }
  return ret;
}

List<HistoricalQuote> getPastYear(String ticker) {
  Stock stock = null;
  try {
    stock = YahooFinance.get(ticker);
  } 
  catch (IOException e) {
    e.printStackTrace();
  }

  Calendar today = Calendar.getInstance();
  Calendar lastYear = Calendar.getInstance();
  lastYear.add(Calendar.YEAR, -1);

  List<HistoricalQuote> stockHistQuotes = null;

  try {
    stockHistQuotes = stock.getHistory(lastYear, today, Interval.DAILY);
  }
  catch (IOException e) {
    e.printStackTrace();
  }

  for (int i = 0; i < stockHistQuotes.size() - 1; i ++) {
    System.out.println(stockHistQuotes.get(i).toString());
  }

  for (int i = 0; i < stockHistQuotes.size() / 2; i ++) {
    HistoricalQuote temp = stockHistQuotes.get(i);
    stockHistQuotes.set(i, stockHistQuotes.get(stockHistQuotes.size() - i - 1));
    stockHistQuotes.set(stockHistQuotes.size() - i - 1, temp);
  }

  for (int i = 0; i < stockHistQuotes.size() - 1; i ++) {
    System.out.println(stockHistQuotes.get(i).toString());
  }
  return stockHistQuotes;
}