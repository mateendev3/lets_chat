import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/chat.dart';
import '../../../models/group.dart';
import '../../../models/message.dart';
import '../../../models/user.dart' as app;
import '../../../utils/common/enums/message_type.dart';
import '../../../utils/common/providers/current_user_provider.dart';
import '../../../utils/common/providers/reply_message_provider.dart';
import '../../../utils/constants/string_constants.dart';
import '../repositories/chat_repository.dart';

final chatControllerProvider = Provider<ChatController>(
  (ref) {
    final chatRepository = ref.watch(chatRepositoryProvider);
    return ChatController(chatRepository: chatRepository, ref: ref);
  },
);

class ChatController {
  ChatController({
    required ChatRepository chatRepository,
    required ProviderRef ref,
  })  : _chatRepository = chatRepository,
        _ref = ref;

  final ChatRepository _chatRepository;
  final ProviderRef _ref;

  Future<void> sendTextMessage(
    BuildContext context, {
    required String lastMessage,
    required String receiverUserId,
    required String? groupId,
    required bool isGroupChat,
  }) async {
    ReplyMessage? replyMessage = _ref.watch(replyMessageProvider);
    app.User senderUser = _ref.watch(currentUserProvider!);

    _chatRepository.sendTextMessage(
      context,
      lastMessage: lastMessage,
      receiverUserId: receiverUserId,
      senderUser: senderUser,
      replyMessage: replyMessage,
      groupId: groupId,
      isGroupChat: isGroupChat,
    );

    _ref.watch(replyMessageProvider.state).state = null;
  }

  Future<void> sendGIFMessage(
    BuildContext context, {
    required String gifUrl,
    required String receiverUserId,
    required String? groupId,
    required bool isGroupChat,
  }) async {
    ReplyMessage? replyMessage = _ref.watch(replyMessageProvider);
    app.User senderUser = _ref.watch(currentUserProvider!);

    _chatRepository.sendGIGMessage(
      context,
      gifUrl: _getGifUrl(gifUrl),
      receiverUserId: receiverUserId,
      senderUser: senderUser,
      replyMessage: replyMessage,
      groupId: groupId,
      isGroupChat: isGroupChat,
    );

    _ref.watch(replyMessageProvider.state).state = null;
  }

  Future<void> sendFileMessage(
    bool mounted,
    BuildContext context, {
    required File file,
    required String receiverUserId,
    required MessageType messageType,
    required String? groupId,
    required bool isGroupChat,
  }) async {
    ReplyMessage? replyMessage = _ref.watch(replyMessageProvider);
    app.User senderUser = _ref.watch(currentUserProvider!);

    _chatRepository.sendFileMessage(
      mounted,
      context,
      file: file,
      receiverUserId: receiverUserId,
      senderUser: senderUser,
      messageType: messageType,
      ref: _ref,
      replyMessage: replyMessage,
      groupId: groupId,
      isGroupChat: isGroupChat,
    );

    _ref.watch(replyMessageProvider.state).state = null;
  }

  Stream<List<Chat>> getChatsList() {
    app.User senderUser = _ref.watch(currentUserProvider!);
    return _chatRepository.getChatsList(senderUserId: senderUser.uid);
  }

  Stream<List<Group>> getGroupChatsList() {
    app.User senderUser = _ref.watch(currentUserProvider!);
    return _chatRepository.getGroupChatsList(currentUserId: senderUser.uid);
  }

  /// invoke to get single chat (messages)
  Stream<List<Message>> getMessagesList({required receiverUserId}) {
    app.User senderUser = _ref.watch(currentUserProvider!);
    return _chatRepository.getMessagesList(
      senderUserId: senderUser.uid,
      receiverUserId: receiverUserId,
    );
  }

  /// invoke to get single group chat (messages)
  Stream<List<Message>> getGroupMessagesList({
    required String groupId,
  }) {
    return _chatRepository.getGroupMessagesList(groupId: groupId);
  }

  Future<void> setChatMessageSeen(
    BuildContext context, {
    required String receiverUserId,
    required String messageId,
  }) async {
    app.User user = _ref.watch(currentUserProvider!);
    _chatRepository.setChatMessageSeen(
      context,
      receiverUserId: receiverUserId,
      senderUserId: user.uid,
      messageId: messageId,
    );
  }

  String _getGifUrl(String gifUrl) {
    String midUrl = gifUrl.substring(gifUrl.lastIndexOf('-') + 1);
    return '${StringsConsts.staticGiphyUrlStart}$midUrl${StringsConsts.staticGiphyUrlEnd}';
  }
}
