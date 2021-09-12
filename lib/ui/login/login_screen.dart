import 'package:amirta_mobile/bloc/login/login_bloc.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/res/resources.dart';
import 'package:amirta_mobile/res/view/shadowed_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final nrkController = TextEditingController();
  final passwordController = TextEditingController();

  bool passwordVisible = false;

  @override
  void dispose() {
    nrkController.dispose();
    passwordController.dispose();
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
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Login Gagal dilakukan.\nSilakan coba lagi'),
                  ),
                );
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
                          "Selamat Datang!",
                          style: context.styleHeadline5,
                        ),
                        Text(
                          "Silakan Login Menggunakan NRK",
                          style: context.styleBody1,
                        ),
                        const SizedBox(
                          height: spaceMedium,
                        ),
                        LabeledInputField(
                          nrkController,
                          label: "NRK",
                        ),
                        LabeledInputField(
                          passwordController,
                          label: "Password",
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
                          "Submit",
                          isLoading: state is LoginLoading,
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
