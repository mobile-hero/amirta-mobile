import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/res/resources.dart';

class ComplaintRejectDialog extends StatefulWidget {
  @override
  _ComplaintRejectDialogState createState() => _ComplaintRejectDialogState();
}

class _ComplaintRejectDialogState extends State<ComplaintRejectDialog> {
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
                'txt_rejection_note'.tr(),
                style: context.styleBody1.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: spaceNormal,
            ),
            LabeledInputField(
              noteController,
              label: 'hint_notes'.tr(),
              padding: const EdgeInsets.only(bottom: spaceBig),
              minLines: 3,
              maxLength: 255,
              onChanged: (value) {
                setState(() {});
              },
            ),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    () {
                      Navigator.pop(context, true);
                    },
                    "btn_confirm".tr(),
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
                    "btn_cancel".tr(),
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
