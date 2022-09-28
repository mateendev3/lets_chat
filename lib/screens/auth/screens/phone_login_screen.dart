import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/common/widgets/helper_widgets.dart';
import '../../../utils/common/widgets/round_button.dart';
import '../../../utils/constants/colors_constants.dart';
import '../controllers/auth_controller.dart';

class PhoneLoginScreen extends ConsumerStatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  ConsumerState<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends ConsumerState<PhoneLoginScreen> {
  late Size _size;
  String? _countryCode;
  late final TextEditingController _phoneNoController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _phoneNoController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: _buildAppBar(),
      body: SizedBox(
        width: _size.width,
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
          addVerticalSpace(_size.width * 0.1),
          _buildInfoText(),
          TextButton(
            onPressed: chooseCountryCode,
            child: Text(
              'Pick Country',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: AppColors.primary,
                    fontSize: _size.width * 0.04,
                  ),
            ),
          ),
          addVerticalSpace(_size.width * 0.08),
          _buildCPickerAndNumberTF(),
          const Expanded(child: SizedBox()),
          if (_isLoading)
            const CircularProgressIndicator(
              color: AppColors.black,
            ),
          const Expanded(child: SizedBox()),
          RoundButton(
            text: 'Next',
            onPressed: _sendOTP,
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
            fontSize: _size.width * 0.04,
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

  Widget _buildCPickerAndNumberTF() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _countryCode ?? '',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: AppColors.primary,
                fontSize: _size.width * 0.05,
              ),
        ),
        addHorizontalSpace(4.0),
        _buildNumberTF(),
      ],
    );
  }

  Widget _buildNumberTF() {
    return SizedBox(
      width: _size.width * 0.7,
      child: TextField(
        controller: _phoneNoController,
        maxLines: 1,
        minLines: 1,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'phone number',
          hintStyle: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: AppColors.grey,
                fontSize: _size.width * 0.05,
                fontWeight: FontWeight.normal,
              ),
        ),
        style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: AppColors.black,
              fontSize: _size.width * 0.05,
            ),
      ),
    );
  }

  void chooseCountryCode() {
    showCountryPicker(
      context: context,
      onSelect: (Country value) {
        setState(() {
          _countryCode = '+${value.phoneCode}';
        });
      },
    );
  }

  /// invoke to send otp to the user.
  void _sendOTP() async {
    if (_phoneNoController.text.isNotEmpty && _countryCode != null) {
      setState(() => _isLoading = true);
      final authController = ref.read<AuthController>(authControllerProvider);
      await authController.signInWithPhone(
        context,
        phoneNumber: '+$_countryCode${_phoneNoController.text}',
      );
    } else {
      showSnackBar(
        context,
        content: 'Please fill the phone number correctly',
      );
    }
    setState(() => _isLoading = false);
  }
}
