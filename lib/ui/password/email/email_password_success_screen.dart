import 'package:amirta_mobile/my_material.dart';

class EmailPasswordSuccessScreen extends StatelessWidget {
  const EmailPasswordSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(spaceBig),
        child: Column(
          children: [
            const Spacer(),
            Image.asset(
              imageRes('img_check_email.png'),
              height: 96,
            ),
            const SizedBox(
              height: spaceBig,
            ),
            Text(
              'txt_check_email'.tr(),
              style: context.styleHeadline6.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: spaceNormal,
            ),
            Text(
              'txt_check_email_desc'.tr(),
              style: context.styleBody1,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Text(
              'txt_check_spam'.tr(),
              style: context.styleBody1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: spaceMedium,
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
    );
  }
}
