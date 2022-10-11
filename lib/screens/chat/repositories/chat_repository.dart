import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../models/chat.dart';
import '../../../models/group.dart';
import '../../../models/message.dart';
import '../../../models/user.dart' as app;
import '../../../utils/common/enums/message_type.dart';
import '../../../utils/common/helper_methods/util_methods.dart';
import '../../../utils/common/providers/reply_message_provider.dart';
import '../../../utils/common/repositories/firebase_storage_repository.dart';
import '../../../utils/common/widgets/helper_widgets.dart';
import '../../../utils/constants/string_constants.dart';

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepository(
    firestore: FirebaseFirestore.instance,
  );
});

class ChatRepository {
  ChatRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  /// invoke to get single chat (messages)
  Stream<List<Message>> getMessagesList({
    required senderUserId,
    required receiverUserId,
  }) {
    return _firestore
        .collection(StringsConsts.usersCollection)
        .doc(senderUserId)
        .collection(StringsConsts.chatsCollection)
        .doc(receiverUserId)
        .collection(StringsConsts.messagesCollection)
        .orderBy('time')
        .snapshots()
        .map(
      (messagesMap) {
        List<Message> messagesList = [];
        for (var messageMap in messagesMap.docs) {
          messagesList.add(Message.fromMap(messageMap.data()));
        }
        return messagesList;
      },
    );
  }

  /// invoke to get single group chat (messages)
  Stream<List<Message>> getGroupMessagesList({
    required String groupId,
  }) {
    return _firestore
        .collection(StringsConsts.groupsCollection)
        .doc(groupId)
        .collection(StringsConsts.chatsCollection)
        .orderBy('time')
        .snapshots()
        .map(
      (messagesMap) {
        List<Message> messagesList = [];
        for (var messageMap in messagesMap.docs) {
          messagesList.add(Message.fromMap(messageMap.data()));
        }
        return messagesList;
      },
    );
  }

  /// invoke to get all chats
  Stream<List<Chat>> getChatsList({
    required senderUserId,
  }) {
    return _firestore
        .collection(StringsConsts.usersCollection)
        .doc(senderUserId)
        .collection(StringsConsts.chatsCollection)
        .snapshots()
        .map(
      (chatsMap) {
        List<Chat> chatsList = [];
        for (var chatMap in chatsMap.docs) {
          chatsList.add(Chat.fromMap(chatMap.data()));
        }
        return chatsList;
      },
    );
  }

  /// invoke to get all groups chats
  Stream<List<Group>> getGroupChatsList({
    required currentUserId,
  }) {
    return _firestore
        .collection(StringsConsts.groupsCollection)
        .snapshots()
        .map(
      (groupChatsMap) {
        List<Group> groupChatsList = [];
        for (var chatMapDocument in groupChatsMap.docs) {
          final Group group = Group.fromMap(chatMapDocument.data());
          if (group.selectedMembersUIds.contains(currentUserId)) {
            groupChatsList.add(group);
          }
        }
        return groupChatsList;
      },
    );
  }

  /// invoke to send text message.
  Future<void> sendTextMessage(
    BuildContext context, {
    required String lastMessage,
    required String receiverUserId,
    required app.User senderUser,
    required ReplyMessage? replyMessage,
    required String? groupId,
    required bool isGroupChat,
  }) async {
    try {
      DateTime time = DateTime.now();
      String messageId = const Uuid().v1();
      app.User? receiverUser;

      if (!isGroupChat) {
        final receiverDocumentSnapshot = await _firestore
            .collection(StringsConsts.usersCollection)
            .doc(receiverUserId)
            .get();
        receiverUser = app.User.fromMap(receiverDocumentSnapshot.data()!);
      }

      // saving chat data to chats sub-collection.
      _saveChatDataToUsersSubCollection(
        senderUser: senderUser,
        receiverUser: receiverUser,
        lastMessage: lastMessage,
        time: time,
        groupId: groupId,
        isGroupChat: isGroupChat,
      );

      // saving message data to message sub collection.
      _saveMessageDataToMessagesSubCollection(
        receiverUserId: receiverUserId,
        senderUserId: senderUser.uid,
        messageId: messageId,
        senderUsername: senderUser.name,
        receiverUsername: receiverUser?.name,
        lastMessage: lastMessage,
        time: time,
        messageType: MessageType.text,
        replyMessage: replyMessage,
        groupId: groupId,
        isGroupChat: isGroupChat,
      );
    } catch (e) {
      showSnackBar(context, content: e.toString());
    }
  }

  /// invoke to send GIF.
  Future<void> sendGIGMessage(
    BuildContext context, {
    required String gifUrl,
    required String receiverUserId,
    required app.User senderUser,
    required ReplyMessage? replyMessage,
    required String? groupId,
    required bool isGroupChat,
  }) async {
    try {
      DateTime time = DateTime.now();
      String messageId = const Uuid().v1();

      app.User? receiverUser;
      if (!isGroupChat) {
        var receiverDocumentSnapshot = await _firestore
            .collection(StringsConsts.usersCollection)
            .doc(receiverUserId)
            .get();
        receiverUser = app.User.fromMap(receiverDocumentSnapshot.data()!);
      }

      // saving chat data to chats sub-collection.
      _saveChatDataToUsersSubCollection(
        senderUser: senderUser,
        receiverUser: receiverUser,
        lastMessage: 'GIF',
        time: time,
        groupId: groupId,
        isGroupChat: isGroupChat,
      );

      // saving message data to message sub collection.
      _saveMessageDataToMessagesSubCollection(
        receiverUserId: receiverUserId,
        senderUserId: senderUser.uid,
        messageId: messageId,
        senderUsername: senderUser.name,
        receiverUsername: receiverUser?.name,
        lastMessage: gifUrl,
        time: time,
        messageType: MessageType.gif,
        replyMessage: replyMessage,
        groupId: groupId,
        isGroupChat: isGroupChat,
      );
    } catch (e) {
      showSnackBar(context, content: e.toString());
    }
  }

  /// invoke to send file message.
  Future<void> sendFileMessage(
    bool mounted,
    BuildContext context, {
    required File file,
    required String receiverUserId,
    required app.User senderUser,
    required ProviderRef ref,
    required MessageType messageType,
    required ReplyMessage? replyMessage,
    required String? groupId,
    required bool isGroupChat,
  }) async {
    try {
      DateTime time = DateTime.now();
      final String messageId = const Uuid().v1();

      // getting receiverUser from firestore and making dart instance.
      app.User? receiverUser;
      if (!isGroupChat) {
        var receiverDocumentSnapshot = await _firestore
            .collection(StringsConsts.usersCollection)
            .doc(receiverUserId)
            .get();
        receiverUser = app.User.fromMap(receiverDocumentSnapshot.data()!);
      }

      // getting sending file downloading url.
      if (!mounted) return;
      String fileName =
          '${messageType.type}/${senderUser.uid}/${receiverUser?.uid ?? groupId}/$messageId';
      final String fileUrl = await ref
          .watch(firebaseStorageRepositoryProvider)
          .storeFileToFirebaseStorage(
            context,
            file: file,
            path: 'chats',
            fileName: fileName,
          );

      // getting file type
      final String fileType = getFileType(messageType);

      _saveChatDataToUsersSubCollection(
        senderUser: senderUser,
        receiverUser: receiverUser,
        lastMessage: fileType,
        time: time,
        groupId: groupId,
        isGroupChat: isGroupChat,
      );

      _saveMessageDataToMessagesSubCollection(
        receiverUserId: receiverUserId,
        senderUserId: senderUser.uid,
        messageId: messageId,
        senderUsername: senderUser.name,
        receiverUsername: receiverUser?.name,
        lastMessage: fileUrl,
        time: time,
        messageType: messageType,
        replyMessage: replyMessage,
        groupId: groupId,
        isGroupChat: isGroupChat,
      );
    } catch (e) {
      showSnackBar(context, content: e.toString());
    }
  }

  /// Invoke to save chat data to users sub collections
  Future<void> _saveChatDataToUsersSubCollection({
    required app.User senderUser,
    required app.User? receiverUser,
    required String lastMessage,
    required DateTime time,
    required String? groupId,
    required bool isGroupChat,
  }) async {
    if (isGroupChat) {
      await _firestore
          .collection(StringsConsts.groupsCollection)
          .doc(groupId)
          .update({
        'lastMessage': lastMessage,
        'time': DateTime.now().millisecondsSinceEpoch,
      });
      return;
    }

    // sender chat
    Chat senderChat = Chat(
      name: receiverUser!.name,
      profilePic: receiverUser.profilePic!,
      userId: receiverUser.uid,
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
      userId: senderUser.uid,
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
    required String? receiverUsername,
    required String lastMessage,
    required DateTime time,
    required MessageType messageType,
    required ReplyMessage? replyMessage,
    required String? groupId,
    required bool isGroupChat,
  }) async {
    final Message message = Message(
      senderUserId: senderUserId,
      receiverUserId: receiverUserId,
      messageId: messageId,
      isSeen: false,
      lastMessage: lastMessage,
      messageType: messageType,
      time: time,
      repliedMessage: replyMessage?.message ?? '',
      repliedTo: replyMessage == null
          ? ''
          : replyMessage.isMe
              ? senderUsername
              : receiverUsername ?? '',
      repliedMessageType:
          replyMessage == null ? MessageType.text : replyMessage.messageType,
    );

    if (isGroupChat) {
      await _firestore
          .collection(StringsConsts.groupsCollection)
          .doc(groupId)
          .collection(StringsConsts.chatsCollection)
          .doc(messageId)
          .set(message.toMap());
      return;
    }

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

  void setChatMessageSeen(
    BuildContext context, {
    required String receiverUserId,
    required String senderUserId,
    required String messageId,
  }) async {
    try {
      // updating seen message to sender user doc
      await _firestore
          .collection(StringsConsts.usersCollection)
          .doc(senderUserId)
          .collection(StringsConsts.chatsCollection)
          .doc(receiverUserId)
          .collection(StringsConsts.messagesCollection)
          .doc(messageId)
          .update({'isSeen': true});

      // updating seen message to receiver user doc
      await _firestore
          .collection(StringsConsts.usersCollection)
          .doc(receiverUserId)
          .collection(StringsConsts.chatsCollection)
          .doc(senderUserId)
          .collection(StringsConsts.messagesCollection)
          .doc(messageId)
          .update({'isSeen': true});
    } catch (e) {
      showSnackBar(context, content: e.toString());
    }
  }
}
