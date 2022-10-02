import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
            buildMaterialIconButton(
              icon: Icons.more_vert,
              onTap: () {},
            ),
            buildMaterialIconButton(
              icon: Icons.camera,
              onTap: () {},
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
  }
}
