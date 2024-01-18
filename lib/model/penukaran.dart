class Penukaran {
  String name;
  String description;
  String type;
  String image;
  int point;

  Penukaran(
      {required this.name,
      required this.description,
      required this.type,
      required this.image,
      required this.point});

  // Penukaran.fromJson(Map<String, dynamic> json) {
  //   name = json['name'];
  //   description = json['description'];
  //   type = json['type'];
  //   image = json['image'];
  //   point = json['point'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['name'] = name;
  //   data['description'] = description;
  //   data['type'] = type;
  //   data['image'] = image;
  //   data['point'] = point;
  //   return data;
  // }
}
