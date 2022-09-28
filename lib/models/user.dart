import 'package:flutter/foundation.dart';

class User {
  User({
    required this.name,
    required this.uid,
    this.profilePic,
    required this.isOnline,
    this.phoneNumber,
    required this.groupId,
  });

  final String name;
  final String uid;
  final String? profilePic;
  final bool isOnline;
  final String? phoneNumber;
  final List<String> groupId;

  User copyWith({
    String? name,
    String? uid,
    String? profilePic,
    bool? isOnline,
    String? phoneNumber,
    List<String>? groupId,
  }) {
    return User(
      name: name ?? this.name,
      uid: uid ?? this.uid,
      profilePic: profilePic ?? this.profilePic,
      isOnline: isOnline ?? this.isOnline,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      groupId: groupId ?? this.groupId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'uid': uid,
      'profilePic': profilePic,
      'isOnline': isOnline,
      'phoneNumber': phoneNumber,
      'groupId': groupId,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      uid: map['uid'] as String,
      profilePic:
          map['profilePic'] != null ? map['profilePic'] as String : null,
      isOnline: map['isOnline'] as bool,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      groupId: (map['groupId'] as List).map((e) => e.toString()).toList(),
    );
  }

  @override
  String toString() {
    return 'User(name: $name, uid: $uid, profilePic: $profilePic, isOnline: $isOnline, phoneNumber: $phoneNumber, groupId: $groupId)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.uid == uid &&
        other.profilePic == profilePic &&
        other.isOnline == isOnline &&
        other.phoneNumber == phoneNumber &&
        listEquals(other.groupId, groupId);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        uid.hashCode ^
        profilePic.hashCode ^
        isOnline.hashCode ^
        phoneNumber.hashCode ^
        groupId.hashCode;
  }
}
