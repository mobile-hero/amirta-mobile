import 'package:amirta_mobile/my_material.dart';

class ChangePasswordSuccessScreen extends StatelessWidget {
  const ChangePasswordSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(spaceBig),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                imageRes('img_change_password.png'),
                height: 96,
              ),
              const SizedBox(
                height: spaceBig,
              ),
              Text(
                'txt_change_password2'.tr(),
                style: context.styleHeadline6.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: spaceNormal,
              ),
              Text(
                'txt_change_password_desc'.tr(),
                style: context.styleBody1,
              ),
              const SizedBox(
                height: 70,
              ),
              PrimaryButton(
                () {
                  Navigator.pop(context);
                },
                'btn_close'.tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
