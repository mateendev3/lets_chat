import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lets_chat/screens/chat/widgets/pop_up_menu_item.dart';
import '../../../utils/common/enums/message_type.dart';
import '../../../utils/common/helper_methods/util_methods.dart';
import '../../../utils/common/widgets/helper_widgets.dart';
import '../../../utils/constants/colors_constants.dart';
import '../controllers/chat_controller.dart';
import 'material_icon_button.dart';

class BottomChatTextField extends ConsumerStatefulWidget {
  const BottomChatTextField({
    Key? key,
    required this.receiverUserId,
  }) : super(key: key);

  final String receiverUserId;

  @override
  ConsumerState<BottomChatTextField> createState() =>
      _BottomChatTextFieldState();
}

class _BottomChatTextFieldState extends ConsumerState<BottomChatTextField> {
  late final TextEditingController _messageController;

  @override
  void initState() {
    _messageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(2, 2),
                  ),
                  BoxShadow(
                      color: Colors.grey.shade200,
                      offset: const Offset(-2, -2),
                      blurRadius: 3,
                      spreadRadius: 1),
                ],
              ),
              child: _buildChatTextField(),
            ),
          ),
          addHorizontalSpace(8.0),
          _buildMicOrSendButton(),
        ],
      ),
    );
  }

  Widget _buildMicOrSendButton() {
    return FloatingActionButton(
      onPressed: _messageController.text.isEmpty
          ? _sendAudioMessage
          : _sendTextMessage,
      child: Icon(
        _messageController.text.isEmpty ? Icons.mic : Icons.send,
        color: AppColors.white,
      ),
    );
  }

  Widget _buildChatTextField() {
    return TextField(
      minLines: 1,
      maxLines: 6,
      onChanged: (value) {
        setState(() {});
      },
      controller: _messageController,
      keyboardType: TextInputType.multiline,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.chatTFFill,
        suffixIconConstraints: const BoxConstraints(),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              clipBehavior: Clip.antiAlias,
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0),
              ),
              child: PopupMenuButton(
                padding: EdgeInsets.zero,
                itemBuilder: (context) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  return [
                    buildPopUpMenuItem(
                      Icons.video_collection_rounded,
                      'Send Video',
                      _pickAndSendVideo,
                    ),
                    buildPopUpMenuItem(
                      Icons.gif,
                      'Send Gif',
                      _pickAndSendGif,
                    ),
                  ];
                },
                child: const Icon(Icons.more_vert),
              ),
            ),
            buildMaterialIconButton(
              icon: Icons.camera,
              onTap: _pickAndSendImage,
            ),
          ],
        ),
        hintText: 'Type a message...',
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.chatScreenGrey,
            ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        contentPadding: const EdgeInsets.only(
          top: 12.0,
          bottom: 12.0,
          left: 16.0,
          right: 0,
        ),
      ),
    );
  }

  void _sendAudioMessage() {}

  void _sendTextMessage() {
    ref.watch(chatControllerProvider).sendTextMessage(
          context,
          lastMessage: _messageController.text.trim(),
          receiverUserId: widget.receiverUserId,
        );
    _messageController.clear();
  }

  /// invoke to send file as a chat
  void _sendFile(File file, MessageType messageType) {
    ref.watch(chatControllerProvider).sendFileMessage(
          mounted,
          context,
          file: file,
          receiverUserId: widget.receiverUserId,
          messageType: messageType,
        );
  }

  void _pickAndSendImage() async {
    File? imageFile = await pickImageFromGallery(context);
    if (imageFile != null) {
      _sendFile(imageFile, MessageType.image);
    }
  }

  void _pickAndSendVideo() async {
    File? videoFile = await pickVideoFromGallery(context);
    if (videoFile != null) {
      _sendFile(videoFile, MessageType.video);
    }
  }

  void _pickAndSendGif() {}
}
