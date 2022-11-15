import 'package:amirta_mobile/my_material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'title_settings'.tr(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(spaceMedium),
        child: Column(
          children: [
            ShadowedContainer(
              borderRadius: cardRadius,
              shadowOffset: const Offset(0, 4),
              shadowBlur: 4,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routes.passwordChange);
                },
                child: ListTile(
                  leading: Transform.translate(
                    offset: const Offset(0, 5),
                    child: ImageIcon(
                      AssetImage(imageRes('ic_password.png')),
                      color: egyptian,
                      size: spaceMedium,
                    ),
                  ),
                  title: Text(
                    'txt_password'.tr(),
                    style: context.styleBody1,
                  ),
                  trailing: const Icon(
                    Icons.keyboard_arrow_right_sharp,
                    color: egyptian,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
