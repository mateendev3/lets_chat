import 'package:flutter/widgets.dart';
import 'package:page_route_animator/page_route_animator.dart';
import 'screens/auth/screens/otp_screen.dart';
import 'screens/auth/screens/phone_login_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/error_screen.dart';
import 'screens/home_screen.dart';
import 'screens/landing_screen.dart';
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
