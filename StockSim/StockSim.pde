import yahoofinance.Stock; //<>//
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
    .setPosition(100,30)
    .setColorBackground(256);
    ;
    
  cp5.addButton("graphNewHistory")
  .setPosition(100,50)
  ;
}


void draw() {
  surface.setTitle(round(frameRate) + " fps");
  background(256, 256, 256);  
  //livePull("NUGT", 1000);
  
  if(cp5.getController("graphNewHistory").isMousePressed()){
    stockHistQuotes.clear();
    stockHistQuotes = getPastYears(cp5.get(Textfield.class, "historyGraphStock").getText(), 1);
    System.out.println(cp5.get(Textfield.class, "historyGraphStock").getText());
  }
  
  graphEntireList(stockHistQuotes, 800, 400, 100, 550,true);
  
  //graphRange(recentQuotes, 800, 400, 100, 550, (int) cp5.getController("pastRangeNumber").getValue());
}