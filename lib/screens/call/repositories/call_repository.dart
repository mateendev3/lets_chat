import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/call.dart';
import '../../../utils/common/providers/current_user_provider.dart';
import '../../../utils/constants/string_constants.dart';

final callRepositoryProvider = Provider<CallRepository>((ref) {
  return CallRepository(FirebaseFirestore.instance, ref);
});

class CallRepository {
  CallRepository(
    FirebaseFirestore firestore,
    ProviderRef ref,
  )   : _firestore = firestore,
        _ref = ref;
  final FirebaseFirestore _firestore;
  final ProviderRef _ref;

  Stream<DocumentSnapshot> get callDocsSnapshotsStream {
    return _firestore
        .collection(StringsConsts.callsCollection)
        .doc(_ref.read(currentUserProvider!).uid)
        .snapshots();
  }

  void createCall(
    BuildContext context, {
    required Call senderCall,
    required Call receiverCall,
  }) async {
    await _firestore
        .collection(StringsConsts.callsCollection)
        .doc(senderCall.callerId)
        .set(senderCall.toMap());

    await _firestore
        .collection(StringsConsts.callsCollection)
        .doc(receiverCall.receiverId)
        .set(receiverCall.toMap());
  }
}
