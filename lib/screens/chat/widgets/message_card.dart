import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lets_chat/utils/common/enums/message_type.dart';
import '../../../utils/constants/colors_constants.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({
    required this.isSender,
    required this.message,
    required this.time,
    required this.messageType,
    super.key,
  });

  final bool isSender;
  final String message;
  final String time;
  final MessageType messageType;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: size.width * 0.8,
          minWidth: 0.0,
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 4.0,
          ),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: isSender ? AppColors.primary : AppColors.onPrimary,
            borderRadius: BorderRadius.only(
              topLeft: isSender ? const Radius.circular(12.0) : Radius.zero,
              topRight: const Radius.circular(12.0),
              bottomLeft: const Radius.circular(12.0),
              bottomRight: isSender ? Radius.zero : const Radius.circular(12.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              messageType == MessageType.text
                  ? Text(
                      textAlign: TextAlign.left,
                      message,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: isSender ? AppColors.white : AppColors.black,
                          ),
                    )
                  : CachedNetworkImage(imageUrl: message),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    time,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: isSender
                              ? AppColors.chatOffWhite
                              : AppColors.grey,
                        ),
                  ),
                  isSender
                      ? const Icon(
                          Icons.check,
                          color: AppColors.chatOffWhite,
                        )
                      : const SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}