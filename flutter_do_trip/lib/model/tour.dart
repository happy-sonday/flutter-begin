class Tour {
  String? title;
  String? tel;
  String? zipcode;
  String? address;
  var id;
  var mapx;
  var mapy;
  String? imagePath;

  Tour({
    this.title,
    this.tel,
    this.zipcode,
    this.address,
    this.id,
    this.mapx,
    this.mapy,
    this.imagePath,
  });

  Tour.fromJson(Map data)
      : title = data['title'],
        tel = data['tel'],
        zipcode = data['zipcode'],
        address = data['addr1'],
        id = data['id'],
        mapx = data['mapx'],
        mapy = data['mapy'],
        imagePath = data['firstimage'];

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'tel': tel,
      'zipcode': zipcode,
      'address': address,
      'id': id,
      'mapx': mapx,
      'mapy': mapy,
      'imagePath': imagePath,
    };
  }
}
