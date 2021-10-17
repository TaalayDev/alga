class Media {
  int? id;
  String? fileName;
  String? url;
  String? thumb;
  String? icon;

  Media({this.id, this.fileName, this.url, this.icon, this.thumb});

  Media.fromMap(map) {
    id = map['id'];
    fileName = map['file_name'];
    url = map['url'];
    thumb = map['thumb'];
    icon = map['icon'];
  }

  static fromList(List list) => list.map((e) => Media.fromMap(e)).toList();
}
