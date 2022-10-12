import 'package:flutter/widgets.dart';
import 'package:page_route_animator/page_route_animator.dart';
import '../models/status.dart';
import '../screens/auth/screens/otp_screen.dart';
import '../screens/auth/screens/phone_login_screen.dart';
import '../screens/chat/screens/chat_screen.dart';
import '../screens/contact/screens/select_receiver_contact_screen.dart';
import '../screens/group/screens/create_group_screen.dart';
import '../screens/group/screens/group_chats_screen.dart';
import '../utils/common/screens/error_screen.dart';
import '../screens/home/screens/home_screen.dart';
import '../screens/landing/screens/landing_screen.dart';
import '../screens/sender_info/screens/sender_user_information_screen.dart';
import '../screens/status/screens/confirm_status_screen.dart';
import '../screens/status/screens/status_screen.dart';
import '../screens/status/screens/watch_status_screen.dart';
import '../utils/constants/routes_constants.dart';

class AppRouter {
  static Route<PageRouteAnimator>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.homeScreen:
        return PageRouteAnimator(
          child: const HomeScreen(),
          routeAnimation: RouteAnimation.rightToLeft,
          settings: settings,
        );
      case AppRoutes.landingScreen:
        return PageRouteAnimator(
          child: const LandingScreen(),
          routeAnimation: RouteAnimation.rightToLeft,
          settings: settings,
        );
      case AppRoutes.phoneLoginScreen:
        return PageRouteAnimator(
          child: const PhoneLoginScreen(),
          routeAnimation: RouteAnimation.rightToLeft,
          settings: settings,
        );
      case AppRoutes.otpScreen:
        return PageRouteAnimator(
          child: const OTPScreen(),
          routeAnimation: RouteAnimation.rightToLeft,
          settings: settings,
        );
      case AppRoutes.userInformationScreen:
        return PageRouteAnimator(
          child: const SenderUserInformationScreen(),
          routeAnimation: RouteAnimation.rightToLeft,
          settings: settings,
        );
      case AppRoutes.chatScreen:
        return PageRouteAnimator(
          child: const ChatScreen(),
          routeAnimation: RouteAnimation.rightToLeft,
          settings: settings,
        );
      case AppRoutes.selectContactScreen:
        return PageRouteAnimator(
          child: const SelectReceiverContactScreen(),
          routeAnimation: RouteAnimation.rightToLeft,
          settings: settings,
        );
      case AppRoutes.statusScreen:
        return PageRouteAnimator(
          child: const StatusScreen(),
          routeAnimation: RouteAnimation.rightToLeft,
          settings: settings,
        );
      case AppRoutes.confirmStatusScreen:
        return PageRouteAnimator(
          child: const ConfirmStatusScreen(),
          fullscreenDialog: true,
          routeAnimation: RouteAnimation.rightToLeft,
          settings: settings,
        );
      case AppRoutes.watchStatusScreen:
        return PageRouteAnimator(
          child: WatchStatusScreen(status: settings.arguments as Status),
          routeAnimation: RouteAnimation.rightToLeft,
        );
      case AppRoutes.createGroupScreen:
        return PageRouteAnimator(
          child: const CreateGroupScreen(),
          routeAnimation: RouteAnimation.rightToLeft,
          settings: settings,
        );
      case AppRoutes.groupChatsScreen:
        return PageRouteAnimator(
          child: const GroupChatScreen(),
          routeAnimation: RouteAnimation.rightToLeft,
          settings: settings,
        );

      default:
        return PageRouteAnimator(
          child: ErrorScreen(error: settings.arguments as String),
          routeAnimation: RouteAnimation.rightToLeft,
          settings: settings,
        );
    }
  }
}
