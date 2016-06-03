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
    .setText("NDAQ")
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

  cp5.addToggle("historyMouseTracking")
    .setPosition(x + 180, y + 20)
    .setSize(10, 10)
    .setColorBackground(0xFFDDDDDD)
    .setValue(true)
    ;

  cp5.addLabel("mouseTrackingToggle")
    .setPosition(x + 75, y + 20)
    .setText("Toggle mouse tracking:")
    .setColor(0)
    ;
}

void setupGraphPastRangeButtons(int x, int y) {
  cp5.addSlider("pastRangeNumber")
    .setPosition(x + 20, y + 10)
    .setRange(30, 600)
    .setValue(120)
    .setColorBackground(0xFFAAAAAA)
    .setColorForeground(0xFF000000)
    .setColorActive(0xFFCCCCCC)
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
    .setPosition(x + 20, y + 30)
    .setSize(47, 17)
    .setText("NDAQ")
    ;  

  cp5.addButton("graphNewLive")
    .setPosition(x + 70, y + 30)
    .setSize(49, 17)
    .setLabel("graph")
    ;

  cp5.addLabel("liveGraphTickerLabel")
    .setPosition(x + 20, y + 20)
    .setText("Ticker:")
    .setColor(0)
    ;
    
    cp5.addToggle("liveGraphEntireList")
    .setPosition(x + 220, y + 20)
    .setSize(10, 10)
    .setColorBackground(0xFFDDDDDD)
    .setValue(false)
    ;
    
    cp5.addLabel("toggleLabel")
    .setPosition(x + 155, y + 20)
    .setText("Graph all plots:")
    .setColor(0xFF000000)
    ;
    
}

void setupGraphModeButtons() {
  String[] things = {"History Graph", "Live Graph"};
  cp5.addButtonBar("graphingMode")
    .setPosition(10, 10)
    .setSize(150, 20)
    .addItems(things)
    .onRelease(new CallbackListener() {
    public void controlEvent(CallbackEvent ev) {
      ButtonBar bar = (ButtonBar)ev.getController();
      if (bar.hover() == 0) {
        hideGraphPastRangeButtons();
        showGraphNewHistoryButtons();
        graphMode = 0;
      } else if (bar.hover() == 1) {
        showGraphPastRangeButtons();
        hideGraphNewHistoryButtons();
        graphMode = 2;
        if(!backgroundPulling){
          backgroundPulling = true;
        }
      }
    }
  }
  )
  ;
  cp5.get(ButtonBar.class, "graphingMode").changeItem("History Graph", "selected", true);
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
  cp5.get(ButtonBar.class, "popularStocks").changeItem("NASDAQ", "selected", true);   // separate cuz returns void
}

void hideGraphNewHistoryButtons() {
  cp5.getController("historyGraphStockLabel").hide();
  cp5.getController("historyGraphYearsLabel").hide();
  cp5.getController("historyGraphStock").hide();
  cp5.getController("historyGraphYears").hide();
  cp5.getController("graphNewHistory").hide();
  cp5.getController("historyMouseTracking").hide();
  cp5.getController("mouseTrackingToggle").hide();
}

void showGraphNewHistoryButtons() {
  cp5.getController("historyGraphStockLabel").show();
  cp5.getController("historyGraphYearsLabel").show();
  cp5.getController("historyGraphStock").show();
  cp5.getController("historyGraphYears").show();
  cp5.getController("graphNewHistory").show();
  cp5.getController("historyMouseTracking").show();
  cp5.getController("mouseTrackingToggle").show();
}

void hideGraphPastRangeButtons() {
  cp5.getController("pastRangeNumber").hide();
  cp5.getController("pastRangeNumberLabel").hide();
  cp5.getController("sliderLeftNumber").hide();
  cp5.getController("sliderRightNumber").hide();
  cp5.getController("liveGraphStock").hide();
  cp5.getController("graphNewLive").hide();
  cp5.getController("liveGraphTickerLabel").hide();
  cp5.getController("liveGraphEntireList").hide();
  cp5.getController("toggleLabel").hide();
}

void showGraphPastRangeButtons() {
  cp5.getController("pastRangeNumber").show();
  cp5.getController("pastRangeNumberLabel").show();
  cp5.getController("sliderLeftNumber").show();
  cp5.getController("sliderRightNumber").show();
  cp5.getController("liveGraphStock").show();
  cp5.getController("graphNewLive").show();
  cp5.getController("liveGraphTickerLabel").show();
  cp5.getController("liveGraphEntireList").show();
  cp5.getController("toggleLabel").show();
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

void graphNewLive() {
  String input = cp5.get(Textfield.class, "liveGraphStock").getText();
  if (input.length() > 0) {
    if (isPopular(input)) {
      graphMode = 2;
      selectedStock = input;
    } else if (graphMode == 2) {
      graphMode = 1;
      livePullStock = input;
    } else {
      livePullStock = input;
    }
  }
}

private boolean isPopular(String tick) {
  for (int i = 0; i < popularTickers.length; i ++) {
    if (tick.equalsIgnoreCase(popularTickers[i])) return true;
  }
  return false;
}