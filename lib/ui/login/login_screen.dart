import 'package:amirta_mobile/bloc/login/login_bloc.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/res/resources.dart';
import 'package:amirta_mobile/res/view/shadowed_container.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final nrkController = TextEditingController();
  final passwordController = TextEditingController();

  bool passwordVisible = false;

  late final resetPassGesture = TapGestureRecognizer();

  @override
  void initState() {
    resetPassGesture.onTap = () {
      Navigator.pushNamed(context, '/password/email');
    };
    super.initState();
  }

  @override
  void dispose() {
    nrkController.dispose();
    passwordController.dispose();
    resetPassGesture.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return LoginBloc(
          context.appProvider().accountRepository,
          context.appProvider(),
        );
      },
      child: Scaffold(
        body: GradientView(
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/main',
                  (route) => false,
                );
              }
              if (state is LoginError) {
                context.showCustomSnackBar('txt_login_error'.tr());
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    child: AppLogo(
                      logoSize: AppLogoSize.big,
                    ),
                  ),
                  ShadowedContainer(
                    shadowColor: null,
                    borderRadiusObject: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    padding: const EdgeInsets.all(spaceBig),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "txt_welcome".tr(),
                          style: context.styleHeadline5,
                        ),
                        Text(
                          "txt_login_nrk".tr(),
                          style: context.styleBody1,
                        ),
                        const SizedBox(
                          height: spaceMedium,
                        ),
                        LabeledInputField(
                          nrkController,
                          label: "txt_nrk".tr(),
                        ),
                        LabeledInputField(
                          passwordController,
                          label: "txt_password".tr(),
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
                        ),
                        PrimaryButton(
                          () {
                            context.read<LoginBloc>().add(LoginNow(
                                  nrkController.text,
                                  passwordController.text,
                                ));
                          },
                          "btn_submit".tr(),
                          isLoading: state is LoginLoading,
                        ),
                        const SizedBox(
                          height: spaceMedium,
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
                        const SizedBox(
                          height: spaceMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
