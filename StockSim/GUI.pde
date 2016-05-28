void graphNewHistory() {
  String input = cp5.get(Textfield.class, "historyGraphStock").getText();
  String input2 = cp5.get(Textfield.class, "historyGraphYears").getText();
  if (input.length() > 0 && input2.length() > 0) {
    stockHistQuotes.clear();
    stockHistQuotes = getPastYears(input, Integer.parseInt(input2));
  } else if (input.length() > 0) {
    stockHistQuotes.clear();
    stockHistQuotes = getPastYears(input, 1);
  }
}

void setupGraphNewHistoryButtons(int x, int y) {

  cp5.addLabel("historyGraphStockLabel")
    .setPosition(x - 2, y)
    .setText("Ticker:")
    .setColor(0)
    ;

  cp5.addLabel("historyGraphYearsLabel")
    .setPosition(x + 32, y)
    .setText("Years:")
    .setColor(0)
    ;

  cp5.addTextfield("historyGraphStock")
    .setPosition(x, y + 10)
    .setSize(37, 20)
    .setText("TSLA")
    ;

  cp5.addTextfield("historyGraphYears")
    .setPosition(x + 40, y + 10)
    .setSize(22, 20)
    .setText("1")
    ;

  cp5.addButton("graphNewHistory")
    .setPosition(x, y + 31)
    .setLabel("graph")
    .setSize(63, 17)
    ;
}

void setupGraphPastRangeButtons(int x, int y) {
  cp5.addSlider("pastRangeNumber")
    .setPosition(x + 20, y + 10)
    .setRange(30, 600)
    .setValue(120)
    ;

  cp5.addLabel("pastRangeNumberLabel")
    .setPosition(x + 13, y)
    .setText("Seconds: (drag to change)")
    .setColor(0)
    ;

  cp5.addLabel("sliderLeftNumber")
    .setPosition(x, y + 10)
    .setText("30")
    .setColor(0)
    ;
  cp5.addLabel("sliderRightNumber")
    .setPosition(x + 120, y + 10)
    .setText("600")
    .setColor(0)
    ;
}

void setupMostPopularBar(int x,int y){
    cp5.addButtonBar("popularStocks")
    .setPosition(x, y)
    .setSize(550, 20)
    .addItems(split("NASDAQ WILSHIRE5000 S&P500 IBM GOOGLE FACEBOOK APPLE AMAZON MICROSOFT INTEL", " "))
    .onRelease(new CallbackListener() {
    public void controlEvent(CallbackEvent ev) {
      ButtonBar bar = (ButtonBar)ev.getController();
      selectedStock = popularTickers[bar.hover()];
      System.out.println(selectedStock);
    }
  }
  )
  ;
}