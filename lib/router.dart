import 'package:flutter/widgets.dart';
import 'package:lets_chat/screens/home_screen.dart';
import 'package:page_route_animator/page_route_animator.dart';

import 'utils/routes_constants.dart';

class AppRouter {
  static Route<PageRouteAnimator>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.homeScreen:
        return PageRouteAnimator(
          child: const HomeScreen(),
          routeAnimation: RouteAnimation.rightToLeft,
        );
      default:
    }
    return null;
  }
}
