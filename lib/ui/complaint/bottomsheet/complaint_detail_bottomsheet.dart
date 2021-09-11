import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/res/resources.dart';
import 'package:amirta_mobile/ui/complaint/bottomsheet/complaint_bottomsheet_content.dart';

class ComplaintDetailBottomSheet extends StatelessWidget {
  final ScrollController scrollController;

  const ComplaintDetailBottomSheet(this.scrollController);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      padding: const EdgeInsets.all(spaceHuge),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ComplaintBottomSheetContent(),
            const SizedBox(
              height: spaceNormal,
            ),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    () {},
                    "btn_take_action".tr(),
                  ),
                ),
                const SizedBox(
                  width: spaceMedium,
                ),
                Expanded(
                  child: SecondaryButton(
                    () {},
                    "btn_reject".tr(),
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
