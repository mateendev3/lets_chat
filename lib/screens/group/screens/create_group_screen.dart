import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/common/widgets/helper_widgets.dart';
import '../../../utils/common/helper_methods/util_methods.dart';
import '../../../utils/constants/assets_constants.dart';
import '../../../utils/constants/colors_constants.dart';
import '../controllers/group_controller.dart';
import '../widgets/group_contacts_list.dart';

class CreateGroupScreen extends ConsumerStatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  ConsumerState<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends ConsumerState<CreateGroupScreen> {
  late TextEditingController _groupNameController;
  Size? _size;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _groupNameController = TextEditingController();
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _size ??= MediaQuery.of(context).size;

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFAB(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      iconTheme: Theme.of(context).iconTheme.copyWith(
            color: AppColors.onPrimary,
          ),
      title: Text(
        'Create Group',
        style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
              color: AppColors.onPrimary,
              fontSize: 18.0,
            ),
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: _size!.width * 0.90,
            height: _size!.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                addVerticalSpace(_size!.width * 0.03),
                _buildProfileImage(),
                addVerticalSpace(_size!.width * 0.03),
                _buildNameTF(),
                addVerticalSpace(_size!.width * 0.04),
                _buildSelectContactHeading(),
                const GroupContactsList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectContactHeading() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Select Contacts',
        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontSize: 18.0,
            ),
      ),
    );
  }

  Widget _buildNameTF() {
    return TextField(
      controller: _groupNameController,
      minLines: 1,
      maxLines: 1,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.group),
        hintText: 'Enter Group Name',
        hintStyle: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: AppColors.grey,
              fontSize: _size!.width * 0.04,
              fontWeight: FontWeight.normal,
            ),
        isDense: true,
      ),
      style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: AppColors.black,
            fontSize: _size!.width * 0.05,
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
                radius: _size!.width * 0.15,
                backgroundColor: AppColors.white,
              )
            : CircleAvatar(
                backgroundImage:
                    const AssetImage(ImagesConsts.icUserNotSelected),
                radius: _size!.width * 0.15,
                backgroundColor: AppColors.white,
              ),
        Positioned(
          top: (_size!.width * 0.35) * 0.55,
          left: (_size!.width * 0.35) * 0.55,
          child: IconButton(
            onPressed: _selectImage,
            icon: Icon(
              Icons.add_a_photo,
              size: _size!.width * 0.075,
            ),
          ),
        ),
      ],
    );
  }

  void _selectImage() async {
    _imageFile = await pickImageFromGallery(context);
    setState(() {});
  }

  Widget _buildFAB() {
    return FloatingActionButton(
      onPressed: createGroup,
      child: const Icon(Icons.done),
    );
  }

  void createGroup() {
    if (_groupNameController.text.trim().isNotEmpty && _imageFile != null) {
      ref.read(groupControllerProvider).createGroup(
            context,
            mounted,
            groupName: _groupNameController.text.trim(),
            groupProfilePic: _imageFile!,
            selectedContacts:
                ref.read<List<Contact>>(selectedContactsGroupProvider),
          );

      ref.read(selectedContactsGroupProvider.state).state = [];
      Navigator.pop(context);
    }
  }
}
