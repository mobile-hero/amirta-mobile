import 'package:amirta_mobile/my_material.dart';

class ChangePasswordSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(spaceBig),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ImageIcon(
                AssetImage(imageRes('img_change_password.png')),
                size: 96,
              ),
              const SizedBox(
                height: spaceMedium,
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
