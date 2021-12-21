class Chat {
  final String image;
  final String title;
  final String content;
  final String time;
  final String count;

  Chat(
      {required this.image,
      required this.title,
      required this.content,
      required this.time,
      required this.count});
}

const String _urlPrefix = "assets/profile_";

List<Chat> chats = [
  Chat(
      image: "${_urlPrefix}woman_3.jpg",
      title: "한소희",
      content: "오늘 저녁에 시간 되시나요?",
      time: "오후 11:00",
      count: "0"),
  Chat(
      image: "${_urlPrefix}woman_2.jpg",
      title: "노제",
      content: "금일 안무 연습 곡은 헤이마마 remix:)",
      time: "오전 11:00",
      count: "1"),
];
