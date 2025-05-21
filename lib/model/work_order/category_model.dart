class Category {
  int? id;
  String? name;
  String? pictureUrl;

  Category({
    this.id,
    this.name,
    this.pictureUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    pictureUrl: json["picture_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "picture_url": pictureUrl,
  };
}