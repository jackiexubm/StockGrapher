import yahoofinance.Stock; //<>//
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
  graphEntireList(stockHistQuotes, 1000, 700, 200, 740);
}


void draw() {
}

void graphEntireList(List<HistoricalQuote> data, float width, float height, float originX, float originY) {

  float xIncrement = width / data.size();
  float[] dataMinMax = getMinMax(data);
  float range = dataMinMax[1] - dataMinMax[0];
  float yMin = dataMinMax[0] - range * .125;
  float yMax = dataMinMax[1] + range * .125;
  float yScale = height / (yMax - yMin);
  float yAxisIncrement = range / 6;

  //draw x & y axis
  line(originX, originY, originX, originY - height);
  line(originX, originY, originX + width, originY);

  // y axis scale
  for (int i = 0; i < 7; i ++) {
    System.out.println(originY - height / 6 * i);
    fill(0);
    textSize(9);
    text((int)(yMin + i * yAxisIncrement), originX - 22, originY - height / 6 * i + 3);
  }

  // y axis scale lines
  stroke(211, 211, 211);  //light grey line
  for (int i = 1; i < 6; i ++) {
    line(originX, originY - height / 6 * i, originX + width, originY - height / 6 * i);
  }

  // x axis scale
  for (int i = 0; i < 4; i ++){
  
  
  }

  // graph

  for (int i = 0; i < data.size() - 1; i ++) {
    stroke(26, 154, 249);   // blue line
    line((float) i * xIncrement + originX, 
      originY - ((data.get(i).getClose().floatValue() - yMin) * yScale), 
      (float) i * xIncrement + xIncrement + originX, 
      originY - ((data.get(i + 1).getClose().floatValue() - yMin) * yScale));


    stroke(210, 234, 252);  // light blue area under line
    line((float) i * xIncrement + originX + 1, 
      originY - ((data.get(i).getClose().floatValue() - yMin) * yScale - 3), 
      (float) i * xIncrement + originX + 1, 
      originY - 1);
  }
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
  lastYear.add(Calendar.YEAR, -1);

  List<HistoricalQuote> stockHistQuotes = null;

  try {
    stockHistQuotes = stock.getHistory(lastYear, today, Interval.DAILY);
  }
  catch (IOException e) {
    e.printStackTrace();
  }

  for (int i = 0; i < stockHistQuotes.size() / 2; i ++) {
    HistoricalQuote temp = stockHistQuotes.get(i);
    stockHistQuotes.set(i, stockHistQuotes.get(stockHistQuotes.size() - i - 1));
    stockHistQuotes.set(stockHistQuotes.size() - i - 1, temp);
  }

  return stockHistQuotes;
}