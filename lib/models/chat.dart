class Chat {
  Chat({
    required this.receiverName,
    required this.receiverProfilePic,
    required this.receiverUserId,
    required this.time,
    required this.lastMessage,
  });

  final String receiverName;
  final String receiverProfilePic;
  final String receiverUserId;
  final DateTime time;
  final String lastMessage;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'receiverName': receiverName,
      'receiverProfilePic': receiverProfilePic,
      'receiverUserId': receiverUserId,
      'time': time.millisecondsSinceEpoch,
      'lastMessage': lastMessage,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      receiverName: map['receiverName'] as String,
      receiverProfilePic: map['receiverProfilePic'] as String,
      receiverUserId: map['receiverUserId'] as String,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      lastMessage: map['lastMessage'] as String,
    );
  }
}
