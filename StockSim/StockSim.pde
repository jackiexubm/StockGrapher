import yahoofinance.Stock; //<>//
import yahoofinance.YahooFinance;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.ArrayList;
import java.util.Calendar;
import java.text.SimpleDateFormat;

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
  float xAxisIncrement = data.size() / 4;

  //draw x & y axis
  stroke(0);
  line(originX, originY, originX, originY - height);
  line(originX, originY, originX + width, originY);

  // graph
  for (int i = 0; i < data.size() - 1; i ++) {
    stroke(229, 243, 252);  // light blue area under line
    line((float) i * xIncrement + originX + 1, 
      originY - ((data.get(i).getClose().floatValue() - yMin) * yScale - 3), 
      (float) i * xIncrement + originX + 1, 
      originY - 1);

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
  text("Date", originX + width/2, originY + 32);

  // y axis scale
  for (int i = 0; i < 7; i ++) {
    fill(0);
    textSize(10);
    text((int)(yMin + i * yAxisIncrement), originX - 22, originY - height / 6 * i + 3);
  }

  // x axis scale.
  for (int i = 0; i < 5; i ++) {
    //get date
    Calendar cal = data.get((int)(i * xAxisIncrement)).getDate();
    // put into good format "month 01, year"
    SimpleDateFormat format1 = new SimpleDateFormat("MMM dd, YYYY");
    text(format1.format(cal.getTime()), originX + width / 4 * i - 27, originY + 15);
  }

  // y axis scale lines
  stroke(200, 200, 200);  //light grey line
  for (int i = 1; i < 6; i ++) {
    line(originX + 1, originY - height / 6 * i, originX + width, originY - height / 6 * i);
  }

  // x axis scale lines
  stroke(200, 200, 200);
  for (int i = 1; i < 4; i ++) {
    line(originX + width / 4 * i, originY - 1, originX + width / 4 * i, originY - height);
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