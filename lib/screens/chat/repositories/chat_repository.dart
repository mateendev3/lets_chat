import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../models/chat.dart';
import '../../../models/message.dart';
import '../../../models/user.dart' as app;
import '../../../utils/common/enums/message_type.dart';
import '../../../utils/common/widgets/helper_widgets.dart';
import '../../../utils/constants/string_constants.dart';

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  );
});

class ChatRepository {
  ChatRepository({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  })  : _auth = auth,
        _firestore = firestore;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  /// invoke to send text message.
  Future<void> sendTextMessage(
    BuildContext context, {
    required String lastMessage,
    required String receiverUserId,
    required app.User senderUser,
  }) async {
    try {
      DateTime time = DateTime.now();
      String messageId = const Uuid().v1();
      app.User receiverUser;

      var receiverDocumentSnapshot = await _firestore
          .collection(StringsConsts.usersCollection)
          .doc(receiverUserId)
          .get();
      receiverUser = app.User.fromMap(receiverDocumentSnapshot.data()!);

      // saving chat data to chats sub-collection.
      _saveChatDataToUsersSubCollection(
        senderUser: senderUser,
        receiverUser: receiverUser,
        lastMessage: lastMessage,
        time: time,
      );

      // saving message data to message sub collection.
      _saveMessageDataToMessagesSubCollection(
        receiverUserId: receiverUserId,
        senderUserId: senderUser.uid,
        messageId: messageId,
        senderUsername: senderUser.name,
        receiverUsername: receiverUser.name,
        lastMessage: lastMessage,
        time: time,
        messageType: MessageType.text,
      );
    } catch (e) {
      showSnackBar(context, content: e.toString());
    }
  }

  /// Invoke to save chat data to users sub collections
  Future<void> _saveChatDataToUsersSubCollection({
    required app.User senderUser,
    required app.User receiverUser,
    required String lastMessage,
    required DateTime time,
  }) async {
    // sender chat
    Chat senderChat = Chat(
      name: receiverUser.name,
      profilePic: receiverUser.profilePic!,
      userId: senderUser.uid,
      time: time,
      lastMessage: lastMessage,
    );
    // saving chat to firestore
    await _firestore
        .collection(StringsConsts.usersCollection)
        .doc(senderUser.uid)
        .collection(StringsConsts.chatsCollection)
        .doc(receiverUser.uid)
        .set(senderChat.toMap());

    // receiver chat
    Chat receiverChat = Chat(
      name: senderUser.name,
      profilePic: senderUser.profilePic!,
      userId: receiverUser.uid,
      time: time,
      lastMessage: lastMessage,
    );
    // saving chat to firestore
    await _firestore
        .collection(StringsConsts.usersCollection)
        .doc(receiverUser.uid)
        .collection(StringsConsts.chatsCollection)
        .doc(senderUser.uid)
        .set(receiverChat.toMap());
  }

  /// invoke to save message data to message sub collection
  Future<void> _saveMessageDataToMessagesSubCollection({
    required String receiverUserId,
    required String senderUserId,
    required String messageId,
    required String senderUsername,
    required String receiverUsername,
    required String lastMessage,
    required DateTime time,
    required MessageType messageType,
  }) async {
    final Message message = Message(
      senderUserId: senderUserId,
      receiverUserId: receiverUserId,
      messageId: messageId,
      isSeen: true,
      lastMessage: lastMessage,
      messageType: messageType,
      time: time,
    );

    // saving message data for sender
    await _firestore
        .collection(StringsConsts.usersCollection)
        .doc(senderUserId)
        .collection(StringsConsts.chatsCollection)
        .doc(receiverUserId)
        .collection(StringsConsts.messagesCollection)
        .doc(messageId)
        .set(message.toMap());

    // saving message data for receiver
    await _firestore
        .collection(StringsConsts.usersCollection)
        .doc(receiverUserId)
        .collection(StringsConsts.chatsCollection)
        .doc(senderUserId)
        .collection(StringsConsts.messagesCollection)
        .doc(messageId)
        .set(message.toMap());
  }
}
