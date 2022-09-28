import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/common/widgets/helper_widgets.dart';
import '../../../utils/constants/colors_constants.dart';
import '../controllers/auth_controller.dart';

class OTPScreen extends ConsumerStatefulWidget {
  const OTPScreen({super.key});

  @override
  ConsumerState<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends ConsumerState<OTPScreen> {
  late String? verificationId;
  late Size _size;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    verificationId = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: _buildAppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            addVerticalSpace(_size.width * 0.1),
            _buildInfoText(),
            addVerticalSpace(_size.width * 0.08),
            _buildNumberTF(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      iconTheme: Theme.of(context).iconTheme.copyWith(
            color: AppColors.onPrimary,
          ),
      title: Text(
        'Enter OTP',
        style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
              color: AppColors.onPrimary,
              fontSize: 18.0,
            ),
      ),
    );
  }

  Widget _buildInfoText() {
    return Text(
      'We have sent an SMS with a code.',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: AppColors.black,
            fontSize: _size.width * 0.04,
          ),
    );
  }

  Widget _buildNumberTF() {
    return SizedBox(
      width: _size.width * 0.5,
      child: TextField(
        maxLines: 1,
        minLines: 1,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        onChanged: (String otp) {
          if (otp.length == 6) {
            FocusManager.instance.primaryFocus?.unfocus();
            verifyOTP(otp);
          }
        },
        maxLength: 6,
        decoration: InputDecoration(
          hintText: '- - - - - -',
          hintStyle: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: AppColors.grey,
                fontSize: _size.width * 0.08,
                fontWeight: FontWeight.normal,
              ),
        ),
        style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: AppColors.black,
              fontSize: _size.width * 0.08,
            ),
      ),
    );
  }

  void verifyOTP(String smsCode) async {
    await ref.watch<AuthController>(authControllerProvider).verifyOTP(
          context,
          mounted,
          verificationId: verificationId!,
          smsCode: smsCode,
        );
  }
}
