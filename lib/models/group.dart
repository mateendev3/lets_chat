class Group {
  Group({
    required this.groupName,
    required this.groupId,
    required this.groupProfilePic,
    required this.lastMessage,
    required this.lastMessageUserSenderId,
    required this.time,
    required this.selectedMembersUIds,
  });

  final String groupName;
  final String groupId;
  final String groupProfilePic;
  final String lastMessage;
  final String lastMessageUserSenderId;
  final DateTime time;
  final List<String> selectedMembersUIds;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'groupName': groupName,
      'groupId': groupId,
      'groupProfilePic': groupProfilePic,
      'lastMessage': lastMessage,
      'lastMessageUserSenderId': lastMessageUserSenderId,
      'time': time.millisecondsSinceEpoch,
      'selectedMembersUIds': selectedMembersUIds,
    };
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      groupName: map['groupName'] as String,
      groupId: map['groupId'] as String,
      groupProfilePic: map['groupProfilePic'] as String,
      lastMessage: map['lastMessage'] as String,
      lastMessageUserSenderId: map['lastMessageUserSenderId'] as String,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      selectedMembersUIds:
          List<String>.from(map['selectedMembersUIds'] as List),
    );
  }
}
