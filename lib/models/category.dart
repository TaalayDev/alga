import 'package:alga/utils/app_box.dart';

class Category {
  int? id;
  Map title;
  Category({this.id, this.title = const {}});

  String get getTitle => title[AppBox.locale?.languageCode ?? 'ru'];

  factory Category.fromMap(map) => Category(
        id: map['id'],
        title: map != null
            ? {'kg': map['title_kg'], 'ru': map['title_ru']}
            : {'kg': '', 'ru': ''},
      );

  static fromList(List list) => list.map((e) => Category.fromMap(e)).toList();

  Map<String, dynamic> toMap() => {
        'title_kg': title['kg'],
        'title_ru': title['ru'],
      };
}
