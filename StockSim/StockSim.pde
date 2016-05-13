import yahoofinance.Stock;
import yahoofinance.YahooFinance;


import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Calendar;
import java.util.Date;

void setup(){
  size(1000,1000);
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
  
  int x = 0;
  for(HistoricalQuote a: stockHistQuotes){
   // point((float)x + 20, a.getHigh().floatValue() * 5 - 300);
   //line((float)x + 20, a.getHigh().floatValue() * 5 - 300, x + 22, a.next().getHigh().floatValue() * 5 - 300);
   
   x = x + 2;
  }
  
  for(int i = stockHistQuotes.size() - 2; i > 0; i --){
  line((float) 602 - i * 2, 600 - (stockHistQuotes.get(i).getHigh().floatValue() * 5 - 300),(float) 600 - i * 2, 600 - (stockHistQuotes.get(i + 1).getHigh().floatValue() * 5 - 300));
  }
}


void draw() {
  
}