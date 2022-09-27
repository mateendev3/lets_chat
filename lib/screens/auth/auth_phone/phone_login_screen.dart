import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import '../../../utils/common/helper_widgets.dart';
import '../../../utils/common/round_button.dart';
import '../../../utils/constants/colors_constants.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  late Size size;
  String? countryCode;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: _buildAppBar(),
      body: SizedBox(
        width: size.width,
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          addVerticalSpace(size.width * 0.1),
          _buildInfoText(),
          TextButton(
            onPressed: chooseCountryCode,
            child: Text(
              'Pick Country',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: AppColors.primary,
                    fontSize: size.width * 0.04,
                  ),
            ),
          ),
          addVerticalSpace(size.width * 0.08),
          _buildCPickerAndNumberTF(size),
          const Expanded(child: SizedBox()),
          RoundButton(
            text: 'Next',
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildInfoText() {
    return Text(
      'LetsChat will need to verify you phone number',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: AppColors.black,
            fontSize: size.width * 0.04,
          ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      iconTheme: Theme.of(context).iconTheme.copyWith(
            color: AppColors.onPrimary,
          ),
      title: Text(
        'Enter your phone number',
        style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
              color: AppColors.onPrimary,
              fontSize: 18.0,
            ),
      ),
    );
  }

  Widget _buildCPickerAndNumberTF(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          countryCode ?? '',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: AppColors.primary,
                fontSize: size.width * 0.05,
              ),
        ),
        addHorizontalSpace(4.0),
        _buildNumberTF(),
      ],
    );
  }

  Widget _buildNumberTF() {
    return SizedBox(
      width: size.width * 0.7,
      child: TextField(
        maxLines: 1,
        minLines: 1,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'phone number',
          hintStyle: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: AppColors.grey,
                fontSize: size.width * 0.05,
                fontWeight: FontWeight.normal,
              ),
        ),
        style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: AppColors.black,
              fontSize: size.width * 0.05,
            ),
      ),
    );
  }

  void chooseCountryCode() {
    showCountryPicker(
      context: context,
      onSelect: (Country value) {
        setState(() {
          countryCode = '+${value.phoneCode}';
        });
      },
    );
  }
}
