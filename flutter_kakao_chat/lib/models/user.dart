class User {
  final String backgroundImage;
  final String name;
  final String intro;

  User(
      {required this.backgroundImage, required this.name, required this.intro});
}

final String _urlPrefix = "assets/profile_";

User me = User(
    backgroundImage: "${_urlPrefix}me.jpg",
    name: "sonday",
    intro: "No pain, No gain");

List<User> friends = [
  User(backgroundImage: "${_urlPrefix}man_1.jpg", name: "홍길동", intro: "호형호제"),
  User(backgroundImage: "${_urlPrefix}man_2.jpg", name: "정도전", intro: "조선 리신"),
  User(backgroundImage: "${_urlPrefix}woman_1.jpg", name: "그란데", intro: "퀸아리"),
  User(backgroundImage: "${_urlPrefix}woman_2.jpg", name: "노제", intro: "헤이 마마"),
  User(backgroundImage: "${_urlPrefix}woman_3.jpg", name: "소희", intro: "누수노시뇽"),
];
