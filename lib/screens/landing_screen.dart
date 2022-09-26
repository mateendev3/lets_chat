import 'package:flutter/material.dart';
import 'package:lets_chat/utils/constants/colors_constants.dart';

import '../utils/constants/assets_constants.dart';
import '../utils/common/helper_widgets.dart';

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
              _buildGetStartedBtn(size, context)
            ],
          ),
        ),
      ),
    );
  }

  Container _buildHeroImage(Size size) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      child: Image.asset(
        ImagesConsts.icLanding1,
        width: size.width * 0.9,
        height: size.width * 0.9,
        fit: BoxFit.cover,
      ),
    );
  }

  SizedBox _buildGetStartedBtn(Size size, BuildContext context) {
    return SizedBox(
      width: size.width,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: size.width * 0.05,
          left: size.width * 0.05,
          right: size.width * 0.05,
        ),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
          ),
          child: Text(
            'Get Started',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontSize: size.width * 0.04,
                ),
          ),
        ),
      ),
    );
  }

  Text _buildTitle(BuildContext context, Size size) {
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
