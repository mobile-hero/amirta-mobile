import 'package:amirta_mobile/my_material.dart';
import 'package:flutter/gestures.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final passController = TextEditingController();
  final passNewController = TextEditingController();
  final passConfirmController = TextEditingController();

  late final resetPassGesture = TapGestureRecognizer();

  @override
  void initState() {
    resetPassGesture.onTap = () {
      Navigator.pushNamed(context, '/password/reset');
    };
    super.initState();
  }

  @override
  void dispose() {
    passController.dispose();
    passNewController.dispose();
    passConfirmController.dispose();
    resetPassGesture.dispose();
    super.dispose();
  }

  bool get isButtonEnabled {
    return passController.text.isNotEmpty &&
        passNewController.text.isNotEmpty &&
        passConfirmController.text.isNotEmpty &&
        passNewController.text == passConfirmController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'title_change_password'.tr(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(spaceMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'txt_change_password'.tr(),
              style: context.styleHeadline4,
            ),
            const SizedBox(
              height: spaceMedium,
            ),
            LabeledInputField(
              passController,
              label: "hint_current_password".tr(),
              isPassword: true,
              onChanged: (value) {
                setState(() {});
              },
            ),
            LabeledInputField(
              passNewController,
              label: "hint_new_password".tr(),
              isPassword: true,
              onChanged: (value) {
                setState(() {});
              },
            ),
            LabeledInputField(
              passConfirmController,
              label: "hint_new_password_confirm".tr(),
              isPassword: true,
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(
              height: spaceMedium,
            ),
            PrimaryButton(
              () {
                Navigator.popAndPushNamed(
                  context,
                  '/password/change/success',
                );
              },
              'btn_change_password'.tr(),
              isEnabled: isButtonEnabled,
            ),
            const SizedBox(
              height: spaceNormal,
            ),
            Text.rich(
              TextSpan(
                style: context.styleBody1.copyWith(
                  color: grease,
                ),
                children: [
                  TextSpan(
                    text: "txt_forgot_password_1".tr(),
                  ),
                  TextSpan(
                    text: "txt_forgot_password_2".tr(),
                    style: TextStyle(
                      color: egyptian,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: resetPassGesture,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
