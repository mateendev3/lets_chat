class Chat {
  Chat({
    required this.name,
    required this.profilePic,
    required this.userId,
    required this.time,
    required this.lastMessage,
  });

  final String name;
  final String profilePic;
  final String userId;
  final DateTime time;
  final String lastMessage;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'profilePic': profilePic,
      'userId': userId,
      'time': time.millisecondsSinceEpoch,
      'lastMessage': lastMessage,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      name: map['name'] as String,
      profilePic: map['profilePic'] as String,
      userId: map['userId'] as String,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      lastMessage: map['lastMessage'] as String,
    );
  }
}
