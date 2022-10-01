import 'package:flutter/material.dart';
import '../../../utils/constants/colors_constants.dart';

Widget buildMaterialIconButton({
  required IconData icon,
  required VoidCallback onTap,
}) {
  return Material(
    clipBehavior: Clip.antiAlias,
    color: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(100.0),
    ),
    child: IconButton(
      onPressed: onTap,
      splashColor: AppColors.grey,
      icon: Icon(
        icon,
        color: AppColors.chatScreenGrey,
      ),
    ),
  );
}
