void livePullPopular(String[] tickers, int interval) {
  if (millis() > nextPull2) {
    try {
      Map<String, Stock> temp = YahooFinance.get(tickers);
      recentPopularStocks.add(temp);
      recentPopularStocks.add(temp);
      recentPopularStocks.add(temp);
    }
    catch(IOException e) {
      e.printStackTrace();
    }
    nextPull2 += interval;
  }
}

void graphRangePopular(List<Map<String, Stock>> list, String ticker, float width, float height, float originX, float originY, int plots) {
  List<Stock> data = new ArrayList<Stock>();
  for (int i = 0; i < list.size(); i++) {
    data.add(list.get(i).get(ticker));
  }
  float xIncrement = width / plots;
  float[] dataMinMax;
  if (data.size() > plots) {
    dataMinMax = getMinMaxStock(data.subList(data.size() - plots, data.size()));
  } else {
    dataMinMax = getMinMaxStock(data);
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
    }

    fill(0);
    textSize(13);
    // y axis title
    text("Price ($)", originX - 100, originY - height * .57);
    // x axis title
    text("Seconds ago (s)", originX + width/2, originY + 30);
  }

  // title
  textSize(12);
  text(data.get(0).getName(), originX + 10, originY - height + 10);
}