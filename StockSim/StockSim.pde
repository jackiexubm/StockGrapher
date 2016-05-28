import yahoofinance.Stock; //<>//
import yahoofinance.YahooFinance;

import controlP5.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.ArrayList;
import java.util.Calendar;
import java.text.SimpleDateFormat;
import java.util.Map;

ControlP5 cp5;
List<Map<String, Stock>> recentPopularStocks;
String[] popularTickers = {"NDAQ","^W5000","^GSPC","IBM","GOOG","FB","AAPL","AMZN","MSFT","INTC"};
List<Stock> recentQuotes;
int nextPull;
int nextPull2;
List<HistoricalQuote> stockHistQuotes;
String selectedStock;


void setup() {
  size(1200, 600);
  background(256, 256, 256);
  recentQuotes = new ArrayList<Stock>();
  recentPopularStocks = new ArrayList<Map<String, Stock>>();
  stockHistQuotes = getPastYears("TSLA", 1);
  selectedStock = "NDAQ";

  cp5 = new ControlP5(this);
  
  cp5.addButtonBar("popularStocks")
    .setPosition(10,10)
    .setSize(550,20)
    .addItems(split("NASDAQ WILSHIRE5000 S&P500 IBM GOOGLE FACEBOOK APPLE AMAZON MICROSOFT INTEL"," "))
    .onRelease(new CallbackListener(){
    public void controlEvent(CallbackEvent ev) {
      ButtonBar bar = (ButtonBar)ev.getController();
      selectedStock = popularTickers[bar.hover()];
      System.out.println(selectedStock);
    }
  })
    ;
  
  
  setupGraphPastRangeButtons(150,70);
  //setupGraphNewHistoryButtons(150, 70);
}


void draw() {
  surface.setTitle(round(frameRate) + " fps");
  background(256, 256, 256);  
  //graphEntireList(stockHistQuotes, 800, 400, 100, 550, true);
  livePullPopular(popularTickers,1000);
  graphRangePopular(recentPopularStocks, selectedStock , 800, 400, 100, 550, (int) cp5.getController("pastRangeNumber").getValue());
  //livePull("NUGT", 1000);
  
  //graphRange(recentQuotes, 800, 400, 100, 550, (int) cp5.getController("pastRangeNumber").getValue());
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

void setupGraphPastRangeButtons(int x, int y){
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