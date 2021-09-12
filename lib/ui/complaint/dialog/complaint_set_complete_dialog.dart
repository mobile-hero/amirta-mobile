import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/res/resources.dart';

class ComplaintSetCompleteDialog extends StatefulWidget {
  @override
  _ComplaintSetCompleteDialogState createState() =>
      _ComplaintSetCompleteDialogState();
}

class _ComplaintSetCompleteDialogState
    extends State<ComplaintSetCompleteDialog> {
  final noteController = TextEditingController();

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: white,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(spaceMedium)),
      insetPadding: const EdgeInsets.all(spaceMedium),
      child: Padding(
        padding: const EdgeInsets.all(spaceBig),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'btn_confirm'.tr(),
                style: context.styleBody1.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: spaceNormal,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'txt_sure_set_complaint_complete'.tr(),
                style: context.styleBody1,
                textAlign: TextAlign.left,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    () {
                      Navigator.pop(context, true);
                    },
                    "btn_yes".tr(),
                  ),
                ),
                const SizedBox(
                  width: spaceSmall,
                ),
                Expanded(
                  child: SecondaryButton(
                    () {
                      Navigator.pop(context);
                    },
                    "btn_no".tr(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
