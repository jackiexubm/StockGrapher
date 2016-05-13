import yahoofinance.Stock;
import yahoofinance.YahooFinance;


import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Calendar;
import java.util.Date;

void setup(){
Stock stock = null;
  try {
    stock = YahooFinance.get("AAPL");
  } 
  catch (IOException e) {
    e.printStackTrace();
  }

  BigDecimal price = stock.getQuote().getPrice();
  BigDecimal change = stock.getQuote().getChangeInPercent();
  BigDecimal peg = stock.getStats().getPeg();
  BigDecimal dividend = stock.getDividend().getAnnualYieldPercent();

  Calendar today = Calendar.getInstance();
  Calendar lastYear = Calendar.getInstance();
  lastYear.add(Calendar.YEAR, -1);
 
 List<HistoricalQuote> stockHistQuotes = null;
  
  try{
  stockHistQuotes = stock.getHistory(lastYear, today, Interval.DAILY);
  }
  catch (IOException e) {
    e.printStackTrace();
  }
  
  for(HistoricalQuote a: stockHistQuotes){
   System.out.println(a);
  }
}


void draw() {
  
}