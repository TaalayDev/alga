class Currency {
  int? id;
  String? name;
  String? symbol;

  Currency({this.id, this.name, this.symbol});

  Currency.fromMap(map) {
    id = map['id'];
    name = map['name'];
    symbol = map['symbol'];
  }

  static fromList(List list) => list.map((e) => Currency.fromMap(e)).toList();
}
