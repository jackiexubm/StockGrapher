class Portfolio {
  int currentAmount;
  int initialAmount;
  int numStocks;

  void setup() {
    this.currentAmount = 0;
    this.initialAmount = 0;
    this.numStocks = 0;
  }

  void draw() {
  }

  void setCurrentAmount(int newAmount) {
    this.currentAmount = newAmount;
  }
  void setInitialAmount(int init) {
    this.initialAmount = init;
  }

  public Portfolio(int curr, int init) {
    this.currentAmount = curr;
    this.initialAmount = init;
  }

  public Portfolio(int curr, int init, int numS) {
    this.currentAmount = curr;
    this.initialAmount = init;
    this.numStocks = numS;
  }

  public String toString() {
    return ("" + initialAmount + ',' + currentAmount+ '\n');
  }

  public String toString(int numS) {
    return ("" + initialAmount + ',' + currentAmount+ ',' + numS + '\n');
  }
}