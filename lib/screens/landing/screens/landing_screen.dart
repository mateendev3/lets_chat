import 'package:flutter/material.dart';
import '../../../utils/common/widgets/round_button.dart';
import '../../../utils/constants/assets_constants.dart';
import '../../../utils/common/widgets/helper_widgets.dart';
import '../../../utils/constants/colors_constants.dart';
import '../../../utils/constants/routes_constants.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              addVerticalSpace(size.height * 0.05),
              _buildTitle(context, size),
              _buildSubTitle(context, size),
              const Expanded(child: SizedBox()),
              _buildHeroImage(size),
              const Expanded(child: SizedBox()),
              RoundButton(
                text: 'Get Started',
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.phoneLoginScreen,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroImage(Size size) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      child: Image.asset(
        ImagesConsts.icLanding2,
        width: size.width * 0.9,
        height: size.width * 0.9,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildTitle(BuildContext context, Size size) {
    return Text(
      'Welcome To LetsChat',
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontSize: size.width * 0.08,
          ),
    );
  }

  Widget _buildSubTitle(BuildContext context, Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        'Easy and free you can get all features here.',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontSize: size.width * 0.04,
              color: AppColors.grey,
              fontWeight: FontWeight.normal,
            ),
      ),
    );
  }
}
