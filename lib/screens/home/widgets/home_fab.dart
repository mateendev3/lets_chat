import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lets_chat/screens/call/screens/call_pickup_screen.dart';
import '../../../utils/common/helper_methods/util_methods.dart';
import '../../../utils/common/widgets/helper_widgets.dart';
import '../../../utils/constants/colors_constants.dart';
import '../../../utils/constants/routes_constants.dart';

class HomeFAB extends StatefulWidget {
  const HomeFAB({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  final TabController tabController;

  @override
  State<HomeFAB> createState() => _HomeFABState();
}

class _HomeFABState extends State<HomeFAB> {
  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(
      () {
        setState(() {
          widget.tabController.indexIsChanging;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    log('calling fab');
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        widget.tabController.index == 0
            ? GestureDetector(
                onTap: () {
                  // Navigator.pushNamed(context, AppRoutes.groupChatsScreen);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const CallPickupScreen(scaffold: Scaffold());
                      },
                    ),
                  );
                },
                child: const CircleAvatar(
                  radius: 24.0,
                  backgroundColor: AppColors.primary,
                  child: Icon(
                    Icons.group,
                    color: AppColors.white,
                  ),
                ),
              )
            : const SizedBox(),
        addVerticalSpace(16.0),
        FloatingActionButton(
          onPressed: () {
            switch (widget.tabController.index) {
              case 0:
                Navigator.pushNamed(context, AppRoutes.selectContactScreen);
                break;
              case 1:
                _selectAndConfirmImage();
                break;
              case 2:
                break;
              default:
                Navigator.pushNamed(context, AppRoutes.errorScreen);
            }
          },
          child: Icon(
            widget.tabController.index == 0 ? Icons.chat_rounded : Icons.image,
          ),
        ),
      ],
    );
  }

  void _selectAndConfirmImage() async {
    File? imageFile = await pickImageFromGallery(context);
    if (imageFile != null) {
      if (!mounted) return;
      log('pushing');
      Navigator.pushNamed(
        context,
        AppRoutes.confirmStatusScreen,
        arguments: imageFile,
      );
    } else {
      if (!mounted) return;
      showSnackBar(context, content: 'Image not selected');
    }
  }
}
