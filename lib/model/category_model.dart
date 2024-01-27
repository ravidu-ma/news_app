class Category {
  String? flag;
  String? name;
  String? img;

  Category({this.flag, this.name, this.img});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(flag: json["flag"], name: json["name"], img: json["img"]);
  }
}
