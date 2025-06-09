class Item {
  String name;
  int quantity;

  // Constructor
  Item(this.name, this.quantity);

  @override
  String toString(){
    return "$name \t\t quantity: $quantity";
  }
}