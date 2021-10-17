class AppLocation {
  int? id;
  final String name;

  AppLocation({
    this.id,
    this.name = '',
  });

  factory AppLocation.fromMap(map) => AppLocation(
        id: map['id'],
        name: map['name'] ?? '',
      );

  static fromList(List list) =>
      list.map((e) => AppLocation.fromMap(e)).toList();
}
