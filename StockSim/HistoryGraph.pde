List<HistoricalQuote> getPastYears(String ticker, int years) {
  Stock stock = null;
  try {
    stock = YahooFinance.get(ticker);
  } 
  catch (IOException e) {

    e.printStackTrace();
  }

  Calendar today = Calendar.getInstance();
  Calendar lastYear = Calendar.getInstance();
  lastYear.add(Calendar.YEAR, - years);

  List<HistoricalQuote> stockHistQuotes = null;

  try {
    stockHistQuotes = stock.getHistory(lastYear, today, Interval.DAILY);

    for (int i = 0; i < stockHistQuotes.size() / 2; i ++) {
      HistoricalQuote temp = stockHistQuotes.get(i);
      stockHistQuotes.set(i, stockHistQuotes.get(stockHistQuotes.size() - i - 1));
      stockHistQuotes.set(stockHistQuotes.size() - i - 1, temp);
    }
  }
  catch (IOException e) {
    System.out.println("INVALID TICKER");
    e.printStackTrace();
    return new ArrayList<HistoricalQuote>();
  }
  return stockHistQuotes;
}

void graphEntireList(List<HistoricalQuote> data, float width, float height, float originX, float originY, boolean mouseOver) {
  //draw x & y axis
  stroke(0);
  line(originX, originY, originX, originY - height);
  line(originX, originY, originX + width, originY);
  
  if (data.size() == 0) {
    textSize(30);
    text("Invalid ticker or range", originX + width/3, originY - height/2);
    return;
  }
  float xIncrement = width / data.size();
  float[] dataMinMax = getMinMax(data);
  float range = dataMinMax[1] - dataMinMax[0];
  float yMin;
  float yMax;
  if (range == 0) {
    yMin = dataMinMax[0] - 1;
    yMax = dataMinMax[1] + 1;
  } else {
    yMin = dataMinMax[0] - range * .125;
    yMax = dataMinMax[1] + range * .125;
  }
  float yScale = height / (yMax - yMin);
  float yAxisIncrement = (yMax - yMin) / 6;
  float xAxisIncrement = data.size() / 4;

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

  // mouse over info
  if (mouseOver) {
    int elementNumber = 0;
    if (mouseX > originX && mouseX < originX + width && mouseY < originY && mouseY > originY - height) {
      stroke(0);

      // get mouse X position rounded to the nearest x increment
      float mouseXPosition = Math.round(mouseX / xIncrement) * xIncrement + .6;
      //vertical line
      line(mouseXPosition, originY, mouseXPosition, originY - height);

      //horizontal line
      elementNumber = (int) ((mouseXPosition - originX) / xIncrement);
      if (elementNumber >= data.size() - 1) {
        elementNumber = data.size() - 2;
      }
      float elementYPosition = originY - ((data.get(elementNumber + 1).getClose().floatValue() - yMin) * yScale);
      line(originX, elementYPosition, originX + width, elementYPosition);

      //intersectionDot
      ellipse(mouseXPosition, elementYPosition, 4, 4);
    }

    //display element info
    stroke(0);
    fill(256, 256, 256);
    rect(originX + 5, originY - 82, 115, 77, 5);
    HistoricalQuote current = data.get(elementNumber);
    fill(0);
    // get title. not implemented at the moment because drastically slows down program
    //try{
    //text(YahooFinance.get(current.getSymbol()).getName(), originX + 7, originY - 90);
    //}catch(IOException e){
    //  e.printStackTrace();
    //}

    //write labels
    text(current.getSymbol(), originX + 50, originY - 70);
    fill(140, 140, 140);
    text("Date:", originX + 9, originY - 60);
    text("Open:", originX + 9, originY - 50);
    text("Close:", originX + 9, originY - 40);
    text("High:", originX + 9, originY - 30);
    text("Low:", originX + 9, originY - 20);
    text("Volume:", originX + 9, originY - 10);

    //write info
    fill(0);
    //get date into nice format
    Calendar cal2 = current.getDate();
    SimpleDateFormat format2 = new SimpleDateFormat("MMM dd, YYYY");
    text(format2.format(cal2.getTime()), originX + 50, originY - 60);
    text("" + current.getOpen(), originX + 50, originY - 50);
    text("" + current.getClose(), originX + 50, originY - 40);
    text("" + current.getHigh(), originX + 50, originY - 30);
    text("" + current.getLow(), originX + 50, originY - 20);
    text("" + current.getVolume(), originX + 50, originY - 10);
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