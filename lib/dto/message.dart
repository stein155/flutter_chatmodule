class Message {
  late String identifier;
  late String text;
  late String imagePath;
  late String createdAt;
  String userUid;
  bool isSender;

  Message(
    this.identifier,
    this.text,
    this.isSender,
    this.createdAt,
    this.userUid,
  );

  Message.fromJson(this.identifier, this.isSender, Map<dynamic, dynamic> json)
      : text = json['text'] ?? '',
        imagePath = json['image_path'] ?? '',
        createdAt = json['created_at'] as String,
        userUid = json['user_uid'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'text': text,
        'image_path': imagePath,
        'created_at': createdAt.toString(),
        'user_uid': userUid
      };

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'image_path': imagePath,
      'created_at': createdAt.toString(),
      'user_uid': userUid
    };
  }
}
