import 'package:flutter/material.dart';
import '../utils/common/helper_widgets.dart';
import '../utils/common/round_button.dart';
import '../utils/constants/assets_constants.dart';
import '../utils/constants/colors_constants.dart';

class UserInformationScreen extends StatefulWidget {
  const UserInformationScreen({super.key});

  @override
  State<UserInformationScreen> createState() => _UserInformationScreenState();
}

class _UserInformationScreenState extends State<UserInformationScreen> {
  late TextEditingController _controller;
  late Size _size;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: _size.width * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                addVerticalSpace(_size.width * 0.1),
                _buildProfileImage(),
                addVerticalSpace(_size.width * 0.1),
                _buildNameTF(),
                const Expanded(child: SizedBox()),
                RoundButton(
                  text: 'Save',
                  onPressed: _saveUserInfo,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameTF() {
    return TextField(
      minLines: 1,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: 'Name',
        hintStyle: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: AppColors.grey,
              fontSize: _size.width * 0.05,
              fontWeight: FontWeight.normal,
            ),
        isDense: true,
        border: const OutlineInputBorder(),
      ),
      style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: AppColors.black,
            fontSize: _size.width * 0.05,
          ),
    );
  }

  Widget _buildProfileImage() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          backgroundImage: const AssetImage(ImagesConsts.icUserNotSelected),
          radius: _size.width * 0.2,
          backgroundColor: AppColors.white,
        ),
        Positioned(
          top: (_size.width * 0.5) * 0.55,
          left: (_size.width * 0.5) * 0.55,
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add_a_photo,
              size: _size.width * 0.1,
            ),
          ),
        ),
      ],
    );
  }

  void _saveUserInfo() {}
}
