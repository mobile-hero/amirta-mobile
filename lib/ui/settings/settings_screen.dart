import 'package:amirta_mobile/my_material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                      color: context.isDark ? borderColor : egyptian,
                      size: spaceMedium,
                    ),
                  ),
                  title: Text(
                    'txt_password'.tr(),
                    style: context.styleBody1,
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right_sharp,
                    color: context.isDark ? borderColor : egyptian,
                  ),
                ),
              ),
            ),
            const SizedBox(height: spaceMedium),
            ShadowedContainer(
              borderRadius: cardRadius,
              shadowOffset: const Offset(0, 4),
              shadowBlur: 4,
              child: InkWell(
                child: ListTile(
                  leading: Transform.translate(
                    offset: const Offset(0, 5),
                    child: Icon(
                      Icons.language,
                      color: context.isDark ? borderColor : egyptian,
                      size: spaceMedium,
                    ),
                  ),
                  title: Text(
                    'txt_language'.tr(),
                    style: context.styleBody1,
                  ),
                  subtitle: FutureBuilder<SharedPreferences>(
                    future: SharedPreferences.getInstance(),
                    builder: (context, snapshot) {
                      final savedLang =
                          snapshot.data!.getString('language') ?? 'en';
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            _createLanguageSelector(
                              context,
                              savedLang,
                              'en',
                              'txt_lang_en'.tr(),
                            ),
                            const SizedBox(width: spaceSmall),
                            _createLanguageSelector(
                              context,
                              savedLang,
                              'id',
                              'txt_lang_id'.tr(),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createLanguageSelector(
    BuildContext context,
    String selection,
    String language,
    String text,
  ) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(
            color: selection == language
                ? context.isDark
                    ? borderColor
                    : egyptian
                : transparent,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextButton(
          child: Text(
            text,
            style: TextStyle(
              color: context.isDark ? textContentColor : egyptian,
            ),
          ),
          style: OutlinedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            backgroundColor: context.isDark ? grey : grey.withOpacity(0.3),
            side: const BorderSide(color: transparent),
          ),
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('language', language);
            late Locale locale;
            switch (language) {
              case 'id':
                locale = const Locale('id', 'ID');
                break;
              case 'en':
                locale = const Locale('en', 'US');
                break;
            }
            await context.setLocale(locale);
          },
        ),
      ),
    );
  }
}
