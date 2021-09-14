import 'package:amirta_mobile/my_material.dart';

class EmailPasswordSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(spaceBig),
        child: Column(
          children: [
            Expanded(child: const SizedBox()),
            ImageIcon(
              AssetImage(imageRes('img_check_email.png')),
              size: 96,
            ),
            const SizedBox(
              height: spaceMedium,
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
            Expanded(child: const SizedBox()),
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
