class ChatModel {
  final String name;
  final String message;
  final String time;
  final String avatarUrl;

  ChatModel({
    required this.name,
    required this.message,
    required this.time,
    required this.avatarUrl,
  });

  static List<ChatModel> dummyData = [
    ChatModel(
      name: "name1",
      message:
          "llong text ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------long text ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------long text ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------long text ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------long text ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------long text ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ong text ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------",
      time: "time1",
      avatarUrl:
          "https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?auto=compress&cs=tinysrgb&w=800",
    ),
    ChatModel(
      name: "name2",
      message: "message1",
      time: "time1",
      avatarUrl:
          "https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?auto=compress&cs=tinysrgb&w=800",
    ),
    ChatModel(
      name: "name3",
      message: "message1",
      time: "time",
      avatarUrl:
          "https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?auto=compress&cs=tinysrgb&w=800",
    ),
    ChatModel(
      name: "name4",
      message: "message1",
      time: "time1",
      avatarUrl:
          "https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?auto=compress&cs=tinysrgb&w=800",
    ),
    ChatModel(
      name: "name5",
      message: "message1",
      time: "time1",
      avatarUrl:
          "https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?auto=compress&cs=tinysrgb&w=800",
    ),
    ChatModel(
      name: "name6",
      message: "message1",
      time: "time1",
      avatarUrl:
          "https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?auto=compress&cs=tinysrgb&w=800",
    ),
    ChatModel(
      name: "name7",
      message: "message1",
      time: "time1",
      avatarUrl:
          "https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?auto=compress&cs=tinysrgb&w=800",
    ),
  ];
}
