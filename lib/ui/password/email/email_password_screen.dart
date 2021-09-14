import 'package:amirta_mobile/my_material.dart';
import 'package:flutter/gestures.dart';

class EmailPasswordScreen extends StatefulWidget {
  @override
  _EmailPasswordScreenState createState() => _EmailPasswordScreenState();
}

class _EmailPasswordScreenState extends State<EmailPasswordScreen> {
  final emailController = TextEditingController();
  
  bool passwordVisible = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  bool get isButtonEnabled {
    return emailController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'title_forgot_password'.tr(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(spaceMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'txt_forgot_password'.tr(),
              style: context.styleHeadline4,
            ),
            const SizedBox(
              height: spaceSmall,
            ),
            Text(
              'txt_forgot_password_desc'.tr(),
              style: context.styleBody1,
            ),
            const SizedBox(
              height: spaceMedium,
            ),
            LabeledInputField(
              emailController,
              label: "txt_email_address".tr(),
              inputType: TextInputType.emailAddress,
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
                  '/password/email/success',
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
