class Stock {
  public String name;
  public String acro;
  public int currentPrice;
  public int tradePrice;

  void setup() {
    this.currentPrice = 0;
    this.tradePrice = 0;
    this.name = "";
   this.acro = "";
  }

  void draw() {
  }

  public Stock(int currP, int tradeP, String name, String acro) {
    this.currentPrice = currP;
    this.tradePrice = tradeP;
    this.name = "";
   this.acro = "";
  }

public String toString() {
    return (name +','+ acro +','+ tradePrice +','+ currentPrice +'\n');
  }

}