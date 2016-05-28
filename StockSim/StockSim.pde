import yahoofinance.Stock; //<>// //<>//
import yahoofinance.YahooFinance;

import controlP5.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.ArrayList;
import java.util.Calendar;
import java.text.SimpleDateFormat;

List<Stock> recentQuotes;
int nextPull;
List<HistoricalQuote> stockHistQuotes;
ControlP5 cp5;


void setup() {
  size(1200, 600);
  background(256, 256, 256);
  recentQuotes = new ArrayList<Stock>();
  stockHistQuotes = getPastYears("TSLA", 1);

  cp5 = new ControlP5(this);
  cp5.addSlider("pastRangeNumber")
    .setPosition(100, 50)
    .setRange(30, 300)
    .setValue(120)
    .hide()
    ;

  //cp5.addButton("getPast");

  cp5.addTextfield("historyGraphStock")
    .setPosition(100, 30)
    .setSize(40, 20);
  ;

  cp5.addTextfield("historyGraphYears")
    .setPosition(143, 30)
    .setSize(16, 20)
    .setColorForeground(200)
    .setDefaultValue(1)
    ;

  cp5.addButton("graphNewHistory")
    .setPosition(100, 51)
    .setLabel("graph")
    .setSize(60, 17)
    ;
}

void draw() {
  surface.setTitle(round(frameRate) + " fps");
  background(256, 256, 256);  
  graphEntireList(stockHistQuotes, 800, 400, 100, 550, true);
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