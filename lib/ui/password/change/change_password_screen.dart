import 'package:amirta_mobile/bloc/password/change/change_password_bloc.dart';
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

  bool passwordVisible = false;
  bool oldPasswordVisible = false;

  @override
  void initState() {
    resetPassGesture.onTap = () {
      Navigator.pushNamed(context, Routes.passwordEmail);
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
    return BlocProvider(
      create: (context) {
        return ChangePasswordBloc(context.appProvider().accountRepository);
      },
      child: BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
          listener: (context, state) {
        if (state is ChangePasswordSuccess) {
          Navigator.popAndPushNamed(
            context,
            Routes.passwordChangeSuccess,
          );
        }
        if (state is ChangePasswordError) {
          context.showCustomSnackBar(state.message);
        }
      }, builder: (context, state) {
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
                  isPassword: !oldPasswordVisible,
                  suffix: InkWell(
                    child: Icon(
                      oldPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                      color: egyptian,
                    ),
                    onTap: () {
                      setState(() {
                        oldPasswordVisible = !oldPasswordVisible;
                      });
                    },
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                LabeledInputField(
                  passNewController,
                  label: "hint_new_password".tr(),
                  isPassword: !passwordVisible,
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
                    context.read<ChangePasswordBloc>().add(ChangePassword(
                          passController.text,
                          passNewController.text,
                          passConfirmController.text,
                        ));
                  },
                  'btn_change_password'.tr(),
                  isEnabled: isButtonEnabled,
                  isLoading: state is ChangePasswordLoading,
                ),
                const SizedBox(
                  height: spaceNormal,
                ),
                Center(
                  child: Text.rich(
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
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
