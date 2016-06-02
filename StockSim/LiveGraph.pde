void livePull(String ticker, int interval) {
  if (millis() > nextPull) {
    if (recentQuotes.size() == 0 || recentQuotes.size() > 0 && ticker.equals(recentQuotes.get(0).getSymbol() )) {
      try {
        recentQuotes.add(YahooFinance.get(ticker));
      } 
      catch (IOException e) {
        e.printStackTrace();
      }
    } else {
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
}

void graphRange(List<Stock> data, float width, float height, float originX, float originY, int plots) {
  //draw x & y axis
  stroke(0);
  line(originX, originY, originX, originY - height);
  line(originX, originY, originX + width, originY);

  float xIncrement = width / plots;
  float[] dataMinMax;
  if (data.size() > plots) {
    dataMinMax = getMinMaxStock(data.subList(data.size() - plots, data.size()));
  } else {
    dataMinMax = getMinMaxStock(data);
  }
  //error handling
  if(dataMinMax[0] == -100){
        System.out.println("ran");
    textSize(30);
    text("Invalid ticker or range", originX + width/3, originY - height/2);
    return;
  }
  
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
  int xAxisIncrement = plots / 4;

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
    }

    fill(0);
    textSize(13);
    // y axis title
    text("Price ($)", originX - 60, originY - height * .57);
    // x axis title
    text("Seconds ago (s)", originX + width/2, originY + 30);
  }

  // title
  textSize(12);
  text(data.get(0).getName(), originX + 10, originY - height + 10);
}


void graphEntireListStock(List<Stock> data, float width, float height, float originX, float originY) {
  //draw x & y axis
  stroke(0);
  line(originX, originY, originX, originY - height);
  line(originX, originY, originX + width, originY);

  //error handle
  if (data.size() == 0) {
    textSize(30);
    text("Invalid ticker or range", originX + width/3, originY - height/2);
    return;
  }

  float xIncrement = width / data.size();
  float[] dataMinMax = getMinMaxStock(data);
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
  int xAxisIncrement = data.size() / 4;

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

  // title
  textSize(12);
  text(data.get(0).getName(), originX + 10, originY - height + 10);
}

float[] getMinMaxStock(List<Stock> data) {
  float[] ret = new float[2];
  ret[0] = -100;
  if(data.get(0).getQuote().getPrice() == null){
    return ret;
  }
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