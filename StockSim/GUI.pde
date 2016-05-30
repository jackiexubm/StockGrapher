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
    
  cp5.addTextfield("liveGraphStock")
    .setPosition(x + 20,y + 30)
    .setSize(47,17)
    ;  
    
  cp5.addButton("graphNewLive")
    .setPosition(x + 70,y + 30)
    .setSize(49,17)
    .setLabel("graph")
    ;
    
  cp5.addLabel("liveGraphTickerLabel")
    .setPosition(x + 20, y + 20)
    .setText("Ticker:")
    .setColor(0)
    ;
}

void setupMostPopularBar(int x, int y) {
  cp5.addButtonBar("popularStocks")
    .setPosition(x, y)
    .setSize(550, 20)
    .addItems(split("NASDAQ WILSHIRE5000 S&P500 IBM GOOGLE FACEBOOK APPLE AMAZON MICROSOFT INTEL", " "))
    .onRelease(new CallbackListener() {
    public void controlEvent(CallbackEvent ev) {
      ButtonBar bar = (ButtonBar)ev.getController();
      if (graphMode == 0) {
        cp5.get(Textfield.class, "historyGraphStock").setText(popularTickers[bar.hover()]);
        graphNewHistory();
      } else if (graphMode == 2) {
        cp5.get(Textfield.class, "liveGraphStock").setText(popularTickers[bar.hover()]);
        selectedStock = popularTickers[bar.hover()];
      } else if (graphMode == 1) {
        graphMode = 2;
        cp5.get(Textfield.class, "liveGraphStock").setText(popularTickers[bar.hover()]);
        selectedStock = popularTickers[bar.hover()];
      }
    }
  }
  )
  ;
}

void hideGraphNewHistoryButtons() {
  cp5.getController("historyGraphStockLabel").hide();
  cp5.getController("historyGraphYearsLabel").hide();
  cp5.getController("historyGraphStock").hide();
  cp5.getController("historyGraphYears").hide();
  cp5.getController("graphNewHistory").hide();
}

void showGraphNewHistoryButtons() {
  cp5.getController("historyGraphStockLabel").show();
  cp5.getController("historyGraphYearsLabel").show();
  cp5.getController("historyGraphStock").show();
  cp5.getController("historyGraphYears").show();
  cp5.getController("graphNewHistory").show();
}

void hideGraphPastRangeButtons() {
  cp5.getController("pastRangeNumber").hide();
  cp5.getController("pastRangeNumberLabel").hide();
  cp5.getController("sliderLeftNumber").hide();
  cp5.getController("sliderRightNumber").hide();
}

void showGraphPastRangeButtons() {
  cp5.getController("pastRangeNumber").show();
  cp5.getController("pastRangeNumberLabel").show();
  cp5.getController("sliderLeftNumber").show();
  cp5.getController("sliderRightNumber").show();
}

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

void graphNewLive(){
  String input = cp5.get(Textfield.class, "liveGraphStock").getText();
  if(input.length() > 0){
  if(isPopular(input)){
    graphMode = 2;
    selectedStock = input;
  }else if(graphMode == 2){
    graphMode = 1;
    livePullStock = input;
  }else{
    livePullStock = input;
  }
  }
}

private boolean isPopular(String tick){
  for(int i = 0; i < popularTickers.length; i ++){
   if(tick.equalsIgnoreCase(popularTickers[i])) return true;
  }
  return false;
}