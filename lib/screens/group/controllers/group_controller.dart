import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/common/providers/current_user_provider.dart';
import '../repositories/group_repository.dart';
import '../../../models/user.dart' as app;

final groupControllerProvider = Provider<GroupController>(
  (ref) {
    return GroupController(
      groupRepository: ref.read(groupRepositoryProvider),
      ref: ref,
    );
  },
);

class GroupController {
  GroupController({
    required GroupRepository groupRepository,
    required ProviderRef ref,
  })  : _groupRepository = groupRepository,
        _ref = ref;

  final GroupRepository _groupRepository;
  final ProviderRef _ref;

  Future<void> createGroup(
    BuildContext context,
    bool mounted, {
    required String groupName,
    required File groupProfilePic,
    required List<Contact> selectedContacts,
  }) async {
    app.User user = _ref.read(currentUserProvider!);
    _groupRepository.createGroup(
      mounted,
      context,
      currentUserId: user.uid,
      groupName: groupName,
      groupProfilePic: groupProfilePic,
      selectedContacts: selectedContacts,
    );
  }
}
