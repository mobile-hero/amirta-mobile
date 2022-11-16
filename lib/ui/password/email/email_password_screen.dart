import 'package:amirta_mobile/bloc/password/email/email_password_bloc.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:email_validator/email_validator.dart';

class EmailPasswordScreen extends StatefulWidget {
  const EmailPasswordScreen({Key? key}) : super(key: key);

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
    return EmailValidator.validate(emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return EmailPasswordBloc(context.appProvider().accountRepository);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'title_forgot_password'.tr(),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<EmailPasswordBloc, EmailPasswordState>(
            listener: (context, state) {
          if (state is EmailPasswordSuccess) {
            Navigator.popAndPushNamed(
              context,
              Routes.passwordEmailSuccess,
            );
          }
          if (state is EmailPasswordError) {
            context.showCustomSnackBar(state.message);
          }
        }, builder: (context, state) {
          return SingleChildScrollView(
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
                  label: 'txt_email_address'.tr(),
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
                    context.read<EmailPasswordBloc>().add(
                          SendResetEmail(emailController.text),
                        );
                  },
                  'btn_reset_password'.tr(),
                  isEnabled: isButtonEnabled,
                  isLoading: state is EmailPasswordLoading,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
