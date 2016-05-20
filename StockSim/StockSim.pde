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
  //List<HistoricalQuote> stockHistQuotes = getPastYear("NUGT");
  //graphEntireList(stockHistQuotes, 1000, 700, 200, 740);
}


void draw() {
  background(256, 256, 256);
  livePull("AAPL", 1000);

  graphRange(recentQuotes, 1000, 700, 200, 740,60);
}

void livePull(String ticker, int interval) {
  if (millis() > nextPull) {
    if (recentQuotes.size() == 0 || recentQuotes.size() > 0 && ticker.equals(recentQuotes.get(0).getSymbol() )) {
      try {
        Stock stock = YahooFinance.get(ticker);
        recentQuotes.add(stock);
      } 
      catch (IOException e) {
        e.printStackTrace();
      }
    } else {
      System.out.println(recentQuotes.get(0).getSymbol());
      recentQuotes.clear();
      try {
        Stock stock = YahooFinance.get(ticker);
        recentQuotes.add(stock);
      } 
      catch (IOException e) {
        e.printStackTrace();
      }
    }
    nextPull += interval;
  }

  System.out.println(recentQuotes.size());
}

void graphRange(List<Stock> data, float width, float height, float originX, float originY, int plots) {
  float xIncrement = width / plots;
  float[] dataMinMax;
  if (data.size() > plots) {
    dataMinMax = getMinMaxStock(data.subList(data.size() - plots, data.size()));
  } else {
    dataMinMax = getMinMaxStock(data);
  }
  float range = dataMinMax[1] - dataMinMax[0];
  float yMin = dataMinMax[0] - range * .125;
  float yMax = dataMinMax[1] + range * .125;
  float yScale = height / (yMax - yMin);
  float yAxisIncrement = (yMax - yMin) / 6;
  int xAxisIncrement = plots / 4;

  //draw x & y axis
  stroke(0);
  line(originX, originY, originX, originY - height);
  line(originX, originY, originX + width, originY);

  // y axis scale
  for (int i = 0; i < 7; i ++) {
    fill(0);
    textSize(10);
    text((float)(yMin + i * yAxisIncrement), originX - 40, originY - height / 6 * i + 3);
  }

  // y axis scale lines
  stroke(210, 210, 210);  //light grey line
  for (int i = 1; i < 6; i ++) {
    line(originX + 1, originY - height / 6 * i, originX + width, originY - height / 6 * i);
  }

  // x axis scale lines
  for (int i = 1; i < 4; i ++) {
    line(originX + width / 4 * i, originY - 1, originX + width / 4 * i, originY - height);
  }

    // x axis scale.
  for (int i = 0; i < 4; i ++) {
   text(plots - i * xAxisIncrement, originX + width / 4 * i - 5, originY + 13);
  }
  text("now", originX + width - 15, originY + 13);

  //graph
  stroke(0, 0, 0);
  if (data.size() > 1) {
    for (int i = 0; i < plots; i++) {
      stroke(229, 243, 252);  // light blue area under line
    line(originX + width - i * xIncrement, 
      originY - ((data.get(data.size() - i - 1).getQuote().getPrice().floatValue() - yMin) * yScale), 
      originX + width - i * xIncrement, 
      originY - 1);
      
      stroke(26, 154, 249); // blue line
      line(originX + width - i * xIncrement, 
        originY - ((data.get(data.size() - i - 1).getQuote().getPrice().floatValue() - yMin) * yScale), 
        originX + width - (i + 1) * xIncrement, 
        originY - ((data.get(data.size() - i - 2).getQuote().getPrice().floatValue() - yMin) * yScale)
        );
      if (i == data.size() - 2) break;

      System.out.println(originY - ((data.get(data.size() - i - 1).getQuote().getPrice().floatValue() - yMin) * yScale));
    }
  }

  fill(0);
  textSize(13);
  text("Price ($)", originX - 100, originY - height * .57);

  // x axis title
  text("Seconds ago (s)", originX + width/2, originY + 30);
}

void graphEntireListStock(List<Stock> data, float width, float height, float originX, float originY) {
  float xIncrement = width / data.size();
  float[] dataMinMax = getMinMaxStock(data);
  float range = dataMinMax[1] - dataMinMax[0];
  float yMin = dataMinMax[0] - range * .125;
  float yMax = dataMinMax[1] + range * .125;
  float yScale = height / (yMax - yMin);
  float yAxisIncrement = (yMax - yMin) / 6;
  int xAxisIncrement = data.size() / 4;

  //draw x & y axis
  stroke(0);
  line(originX, originY, originX, originY - height);
  line(originX, originY, originX + width, originY);

  // graph
  for (int i = 0; i < data.size() - 1; i ++) {
    //graph area under line
    stroke(229, 243, 252);  // light blue area under line
    line((float) i * xIncrement + originX + 1, 
      originY - ((data.get(i).getQuote().getPrice().floatValue() - yMin) * yScale), 
      (float) i * xIncrement + originX + 1, 
      originY - 1);
    //graph line
    stroke(26, 154, 249);   // blue line
    line((float) i * xIncrement + originX, 
      originY - ((data.get(i).getQuote().getPrice().floatValue() - yMin) * yScale), 
      (float) i * xIncrement + xIncrement + originX, 
      originY - ((data.get(i + 1).getQuote().getPrice().floatValue() - yMin) * yScale));
  }

  // y axis title
  fill(0);
  textSize(13);
  text("Price ($)", originX - 100, originY - height * .57);

  // x axis title
  text("Time elapsed (s)", originX + width/2, originY + 30);

  // y axis scale
  for (int i = 0; i < 7; i ++) {
    fill(0);
    textSize(10);
    text((float)(yMin + i * yAxisIncrement), originX - 39, originY - height / 6 * i + 3);
  }

  // x axis scale.
  for (int i = 0; i < 4; i ++) {
   text(data.size() - i * xAxisIncrement, originX + width / 4 * i, originY + 13);
  }
  text("now", originX + width - 15, originY + 13);

  // y axis scale lines
  stroke(210, 210, 210);  //light grey line
  for (int i = 1; i < 6; i ++) {
    line(originX + 1, originY - height / 6 * i, originX + width, originY - height / 6 * i);
  }

  // x axis scale lines
  for (int i = 1; i < 4; i ++) {
    line(originX + width / 4 * i, originY - 1, originX + width / 4 * i, originY - height);
  }
}


void graphEntireList(List<HistoricalQuote> data, float width, float height, float originX, float originY) {
  float xIncrement = width / data.size();
  float[] dataMinMax = getMinMax(data);
  float range = dataMinMax[1] - dataMinMax[0];
  float yMin = dataMinMax[0] - range * .125;
  float yMax = dataMinMax[1] + range * .125;
  float yScale = height / (yMax - yMin);
  float yAxisIncrement = (yMax - yMin) / 6;
  float xAxisIncrement = data.size() / 4;

  //draw x & y axis
  stroke(0);
  line(originX, originY, originX, originY - height);
  line(originX, originY, originX + width, originY);

  // graph
  for (int i = 0; i < data.size() - 1; i ++) {
    //graph area under line
    stroke(229, 243, 252);  // light blue area under line
    line((float) i * xIncrement + originX + 1, 
      originY - ((data.get(i).getClose().floatValue() - yMin) * yScale), 
      (float) i * xIncrement + originX + 1, 
      originY - 1);
    //graph line
    stroke(26, 154, 249);   // blue line
    line((float) i * xIncrement + originX, 
      originY - ((data.get(i).getClose().floatValue() - yMin) * yScale), 
      (float) i * xIncrement + xIncrement + originX, 
      originY - ((data.get(i + 1).getClose().floatValue() - yMin) * yScale));
  }

  // y axis title
  fill(0);
  textSize(13);
  text("Close Price ($)", originX - 100, originY - height * .57);

  // x axis title
  text("Date", originX + width/2, originY + 30);

  // y axis scale
  for (int i = 0; i < 7; i ++) {
    fill(0);
    textSize(10);
    text((int)(yMin + i * yAxisIncrement), originX - 24, originY - height / 6 * i + 3);
  }

  // x axis scale.
  for (int i = 0; i < 4; i ++) {
    //get date
    Calendar cal = data.get((int)(i * xAxisIncrement)).getDate();
    // put into good format "month 01, year"
    SimpleDateFormat format1 = new SimpleDateFormat("MMM dd, YYYY");
    text(format1.format(cal.getTime()), originX + width / 4 * i - 30, originY + 13);
  }

  Calendar cal = Calendar.getInstance();
  // put into good format "month 01, year"
  SimpleDateFormat format1 = new SimpleDateFormat("MMM dd, YYYY");
  text(format1.format(cal.getTime()), originX + width - 30, originY + 13);

  // y axis scale lines
  stroke(210, 210, 210);  //light grey line
  for (int i = 1; i < 6; i ++) {
    line(originX + 1, originY - height / 6 * i, originX + width, originY - height / 6 * i);
  }

  // x axis scale lines
  for (int i = 1; i < 4; i ++) {
    line(originX + width / 4 * i, originY - 1, originX + width / 4 * i, originY - height);
  }
}

float[] getMinMaxStock(List<Stock> data) {
  float[] ret = new float[2];
  ret[0] = data.get(0).getQuote().getPrice().floatValue();
  ret[1] = data.get(0).getQuote().getPrice().floatValue();
  for (int i = 0; i < data.size(); i ++) {
    float value = data.get(i).getQuote().getPrice().floatValue();
    if (value < ret[0]) {
      ret[0] = value;
    } else if (value > ret[1]) {
      ret[1] = value;
    }
  }
  return ret;
}

float[] getMinMax(List<HistoricalQuote> data) {
  float[] ret = new float[2];
  ret[0] = data.get(0).getClose().floatValue();
  ret[1] = data.get(0).getClose().floatValue();
  for (int i = 0; i < data.size(); i ++) {
    float value = data.get(i).getClose().floatValue();
    if (value < ret[0]) {
      ret[0] = value;
    } else if (value > ret[1]) {
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
  lastYear.add(Calendar.YEAR, -2);

  List<HistoricalQuote> stockHistQuotes = null;

  try {
    stockHistQuotes = stock.getHistory(lastYear, today, Interval.DAILY);
  }
  catch (IOException e) {
    System.out.println("INVALID TICKER");
    e.printStackTrace();
  }

  for (int i = 0; i < stockHistQuotes.size() / 2; i ++) {
    HistoricalQuote temp = stockHistQuotes.get(i);
    stockHistQuotes.set(i, stockHistQuotes.get(stockHistQuotes.size() - i - 1));
    stockHistQuotes.set(stockHistQuotes.size() - i - 1, temp);
  }


  return stockHistQuotes;
}