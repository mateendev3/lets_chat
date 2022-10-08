import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../models/status.dart';
import '../../../utils/common/widgets/loader.dart';
import '../../../utils/constants/routes_constants.dart';
import '../../chat/widgets/no_chat.dart';
import '../controllers/status_controller.dart';

class StatusScreen extends ConsumerWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<Status>>(
      future: ref.watch(statusControllerProvider).getStatuses(context),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Loader();
        }

        return snapshot.data!.isEmpty
            ? const NoChat()
            : ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Status status = snapshot.data![index];
                  return _buildChatListItem(context, index, status);
                },
              );
      },
    );
  }

  Widget _buildChatListItem(BuildContext context, int index, Status status) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.watchStatusScreen,
            arguments: status,
          );
        },
        title: Text(
          status.username,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: size.width * 0.045,
              ),
        ),
        leading: CircleAvatar(
          radius: 30.0,
          backgroundImage: NetworkImage(
            status.profilePic!,
          ),
        ),
        trailing: Text(
          DateFormat.Hm().format(status.time),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: size.width * 0.030,
              ),
        ),
      ),
    );
  }
}
