import 'package:amirta_mobile/my_material.dart';
import 'package:flutter/gestures.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final passNewController = TextEditingController();
  final passConfirmController = TextEditingController();
  
  bool passwordVisible = false;

  @override
  void dispose() {
    passNewController.dispose();
    passConfirmController.dispose();
    super.dispose();
  }

  bool get isButtonEnabled {
    return passNewController.text.isNotEmpty &&
        passConfirmController.text.isNotEmpty &&
        passNewController.text == passConfirmController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'title_new_password'.tr(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(spaceMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'txt_new_password'.tr(),
              style: context.styleHeadline4,
            ),
            const SizedBox(
              height: spaceSmall,
            ),
            Text(
              'txt_new_password_desc'.tr(),
              style: context.styleBody1,
            ),
            const SizedBox(
              height: spaceMedium,
            ),
            LabeledInputField(
              passNewController,
              label: "hint_new_password".tr(),
              isPassword: true,
              suffix: InkWell(
                child: Icon(
                  passwordVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                  color: egyptian,
                ),
                onTap: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
              ),
              suffixConstraints: BoxConstraints(
                maxHeight: 20,
              ),
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
              'btn_reset_password'.tr(),
              isEnabled: isButtonEnabled,
            ),
          ],
        ),
      ),
    );
  }
}
