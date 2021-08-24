import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/res/resources.dart';
import 'package:amirta_mobile/res/view/shadowed_container.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientView(
        child: Column(
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
                    TextEditingController(),
                    label: "NRK",
                  ),
                  LabeledInputField(
                    TextEditingController(),
                    label: "Password",
                  ),
                  PrimaryButton(
                      () {},
                    "Submit",
                  ),
                  const SizedBox(
                    height: spaceMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
