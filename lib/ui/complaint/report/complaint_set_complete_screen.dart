import 'package:amirta_mobile/my_material.dart';

class ComplaintSetCompleteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'txt_complaint_completed'.tr(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(spaceBig),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                imageRes('img_pengaduan_selesai.png'),
                height: 130,
              ),
              const SizedBox(
                height: spaceHuge,
              ),
              Text.rich(
                TextSpan(
                  style: context.styleBody1,
                  children: [
                    TextSpan(
                      text: "txt_set_complaint_complete_1".tr(),
                    ),
                    TextSpan(
                      text: "txt_set_complaint_complete_2".tr(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              PrimaryButton(
                () {
                  Navigator.popAndPushNamed(
                    context,
                    '/complaint/create-report',
                  );
                },
                "btn_next".tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
