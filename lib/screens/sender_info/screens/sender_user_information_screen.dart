import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/common/widgets/helper_widgets.dart';
import '../../../utils/common/widgets/round_button.dart';
import '../../../utils/common/helper_methods/util_methods.dart';
import '../../../utils/constants/assets_constants.dart';
import '../../../utils/constants/colors_constants.dart';
import '../controllers/sender_user_data_controller.dart';

class SenderUserInformationScreen extends ConsumerStatefulWidget {
  const SenderUserInformationScreen({super.key});

  @override
  ConsumerState<SenderUserInformationScreen> createState() =>
      _SenderUserInformationScreenState();
}

class _SenderUserInformationScreenState
    extends ConsumerState<SenderUserInformationScreen> {
  late TextEditingController _nameController;
  late Size _size;
  File? _imageFile;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;

    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: _size.width * 0.8,
            height: _size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                addVerticalSpace(_size.width * 0.1),
                _buildProfileImage(),
                addVerticalSpace(_size.width * 0.1),
                _buildNameTF(),
                const Expanded(child: SizedBox()),
                if (_isLoading)
                  const CircularProgressIndicator(
                    color: AppColors.black,
                  ),
                const Expanded(child: SizedBox()),
                RoundButton(
                  text: 'Save',
                  onPressed: _saveUserInfo,
                ),
                addVerticalSpace(_size.width * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameTF() {
    return TextField(
      controller: _nameController,
      minLines: 1,
      maxLines: 1,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person),
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
        _imageFile != null
            ? CircleAvatar(
                backgroundImage: FileImage(_imageFile!),
                radius: _size.width * 0.2,
                backgroundColor: AppColors.white,
              )
            : CircleAvatar(
                backgroundImage:
                    const AssetImage(ImagesConsts.icUserNotSelected),
                radius: _size.width * 0.2,
                backgroundColor: AppColors.white,
              ),
        Positioned(
          top: (_size.width * 0.5) * 0.55,
          left: (_size.width * 0.5) * 0.55,
          child: IconButton(
            onPressed: _selectImage,
            icon: Icon(
              Icons.add_a_photo,
              size: _size.width * 0.1,
            ),
          ),
        ),
      ],
    );
  }

  void _saveUserInfo() async {
    setState(() => _isLoading = true);
    if (_nameController.text.isNotEmpty) {
      await ref
          .read(senderUserDataControllerProvider)
          .saveSenderUserDataToFirebase(
            context,
            mounted,
            userName: _nameController.text,
            imageFile: _imageFile,
          );
    } else {
      showSnackBar(context, content: 'Please Enter Name');
    }
    setState(() => _isLoading = false);
  }

  void _selectImage() async {
    _imageFile = await pickImageFromGallery(context);
    setState(() {});
  }
}
