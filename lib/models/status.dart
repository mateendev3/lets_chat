class Status {
  Status({
    required this.uid,
    required this.username,
    required this.phoneNumber,
    required this.profilePic,
    required this.statusId,
    required this.photoUrls,
    required this.whoCanSee,
    required this.time,
  });

  final String uid;
  final String username;
  final String? phoneNumber;
  final String? profilePic;
  final String statusId;
  final List<String> photoUrls;
  final List<String> whoCanSee;
  final DateTime time;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'username': username,
      'phoneNumber': phoneNumber,
      'profilePic': profilePic,
      'statusId': statusId,
      'photoUrls': photoUrls,
      'whoCanSee': whoCanSee,
      'time': time.millisecondsSinceEpoch,
    };
  }

  factory Status.fromMap(Map<String, dynamic> map) {
    return Status(
      uid: map['uid'] as String,
      username: map['username'] as String,
      phoneNumber: map['phoneNumber'] as String,
      profilePic: map['profilePic'] as String,
      statusId: map['statusId'] as String,
      photoUrls: List<String>.from(map['photoUrls'] as List),
      whoCanSee: List<String>.from(map['whoCanSee'] as List),
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
    );
  }
}
