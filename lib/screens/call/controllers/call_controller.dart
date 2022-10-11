import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../models/call.dart';
import '../../../models/user.dart' as app;
import '../../../utils/common/providers/current_user_provider.dart';
import '../repositories/call_repository.dart';

final callControllerProvider = Provider<CallController>(
  (ref) {
    return CallController(
      callRepository: ref.read(callRepositoryProvider),
      ref: ref,
    );
  },
);

class CallController {
  CallController({
    required CallRepository callRepository,
    required ProviderRef ref,
  })  : _callRepository = callRepository,
        _ref = ref;

  final CallRepository _callRepository;
  final ProviderRef _ref;

  Future<void> createCall(
    bool mounted,
    BuildContext context, {
    required String receiverName,
    required String receiverId,
    required String receiverProfilePic,
    required bool isGroupChat,
  }) async {
    final String callId = const Uuid().v1();
    app.User user = _ref.read(currentUserProvider!);

    final Call senderCall = Call(
      callerId: user.uid,
      callerName: user.name,
      callerPic: user.profilePic!,
      receiverId: receiverId,
      receiverName: receiverName,
      receiverPic: receiverProfilePic,
      callId: callId,
      hasDialled: true,
    );

    final Call receiverCall = Call(
      callerId: user.uid,
      callerName: user.name,
      callerPic: user.profilePic!,
      receiverId: receiverId,
      receiverName: receiverName,
      receiverPic: receiverProfilePic,
      callId: callId,
      hasDialled: false,
    );

    _callRepository.createCall(
      context,
      senderCall: senderCall,
      receiverCall: receiverCall,
    );
  }
}
