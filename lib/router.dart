import 'package:flutter/widgets.dart';
import 'package:lets_chat/screens/chat_screen.dart';
import 'package:lets_chat/screens/error_screen.dart';
import 'package:lets_chat/screens/home_screen.dart';
import 'package:page_route_animator/page_route_animator.dart';

import 'utils/constants/routes_constants.dart';

class AppRouter {
  static Route<PageRouteAnimator>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.homeScreen:
        return PageRouteAnimator(
          child: const HomeScreen(),
          routeAnimation: RouteAnimation.rightToLeft,
          settings: settings,
        );
      case AppRoutes.chatScreen:
        return PageRouteAnimator(
          child: const ChatScreen(),
          routeAnimation: RouteAnimation.rightToLeft,
          settings: settings,
        );
      default:
        return PageRouteAnimator(
          child: const ErrorScreen(),
          routeAnimation: RouteAnimation.rightToLeft,
          settings: settings,
        );
    }
  }
}
