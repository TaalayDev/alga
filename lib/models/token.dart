import 'package:hive/hive.dart';

import 'model.dart';

part 'token.g.dart';

@HiveType(typeId: 0)
class Token extends Model {
  @HiveField(0)
  String? access;
  @HiveField(1)
  String? refresh;

  Token({this.access, this.refresh});

  Token.fromMap(map) {
    access = map['access'];
    refresh = map['refresh'];
  }

  Token copyWith({String? access, String? refresh}) => Token(
        access: access ?? this.access,
        refresh: refresh ?? this.refresh,
      );

  Token copy(Token token) => Token(
        access: token.access ?? this.access,
        refresh: token.refresh ?? this.refresh,
      );

  @override
  Map<String, dynamic> toMap() => {
        'access': access,
        'refresh': refresh,
      };
}
