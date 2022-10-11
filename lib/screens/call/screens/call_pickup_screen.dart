import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/call.dart';
import '../../../utils/constants/colors_constants.dart';
import '../controllers/call_controller.dart';
import 'call_screen.dart';

class CallPickupScreen extends ConsumerWidget {
  const CallPickupScreen({
    required this.scaffold,
    Key? key,
  }) : super(key: key);

  final Widget scaffold;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<DocumentSnapshot>(
      stream: ref.watch(callControllerProvider).callDocsSnapshotsStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.data() != null) {
          Call call =
              Call.fromMap(snapshot.data!.data() as Map<String, dynamic>);

          if (!call.hasDialled) {
            return Scaffold(
              body: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 48.0),
                    Text(
                      'Incoming Call',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(fontSize: 36.0),
                    ),
                    const SizedBox(height: 48.0),
                    CircleAvatar(
                      radius: 64.0,
                      backgroundImage: NetworkImage(call.callerPic),
                    ),
                    const SizedBox(height: 24.0),
                    Text(
                      call.callerName,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(
                              fontSize: 28.0,
                              fontWeight: FontWeight.w900,
                              color: AppColors.black.withOpacity(0.7)),
                    ),
                    const SizedBox(height: 64.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          iconSize: 54.0,
                          onPressed: () {},
                          icon: const Icon(
                            Icons.call_end,
                            color: AppColors.red,
                          ),
                        ),
                        const SizedBox(width: 48.0),
                        IconButton(
                          iconSize: 54.0,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CallScreen(
                                  channelId: call.callId,
                                  call: call,
                                  isGroupChat: false,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.call,
                            color: AppColors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        }
        return scaffold;
      },
    );
  }
}
