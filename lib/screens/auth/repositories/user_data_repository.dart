import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataRepository {
  UserDataRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;
}
