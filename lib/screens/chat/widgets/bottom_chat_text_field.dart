import 'package:flutter/material.dart';
import 'package:lets_chat/screens/chat/widgets/material_icon_button.dart';
import 'package:lets_chat/utils/common/widgets/helper_widgets.dart';
import '../../../utils/constants/colors_constants.dart';

class BottomChatTextField extends StatefulWidget {
  const BottomChatTextField({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomChatTextField> createState() => _BottomChatTextFieldState();
}

class _BottomChatTextFieldState extends State<BottomChatTextField> {
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
          const CircleAvatar(
            backgroundColor: AppColors.primary,
            radius: 24.0,
            child: Icon(
              Icons.send,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatTextField() {
    return TextField(
      minLines: 1,
      maxLines: 6,
      keyboardType: TextInputType.multiline,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.chatTFFill,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 0.0),
          child: Row(
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
        ),
        hintText: 'Type a message...',
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.chatScreenGrey,
            ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
      ),
    );
  }
}
