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

  Chat copyWith({
    String? name,
    String? profilePic,
    String? chatId,
    DateTime? time,
    String? lastMessage,
  }) {
    return Chat(
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      userId: chatId ?? userId,
      time: time ?? this.time,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'profilePic': profilePic,
      'chatId': userId,
      'time': time.millisecondsSinceEpoch,
      'lastMessage': lastMessage,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      name: map['name'] as String,
      profilePic: map['profilePic'] as String,
      userId: map['chatId'] as String,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      lastMessage: map['lastMessage'] as String,
    );
  }
}
