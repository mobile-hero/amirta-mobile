import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/res/resources.dart';
import 'package:amirta_mobile/ui/complaint/bottomsheet/complaint_bottomsheet_content.dart';
import 'package:slide_to_act/slide_to_act.dart';

class ComplaintRejectedBottomSheet extends StatelessWidget {
  final ScrollController scrollController;

  const ComplaintRejectedBottomSheet(this.scrollController);

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
            Center(
              child: Container(
                padding: const EdgeInsets.all(spaceTiny),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: scarlet.withOpacity(0.2),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: scarlet,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.clear_rounded,
                        color: white,
                        size: spaceMedium,
                      ),
                    ),
                    const SizedBox(
                      width: spaceTiny,
                    ),
                    Text(
                      "txt_complaint_rejected".tr(),
                      style: context.styleBody1.copyWith(
                        fontWeight: FontWeight.w600,
                        color: scarlet,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: spaceMedium,
            ),
            TitleValueBox(
              title: "txt_rejection_note".tr(),
              value: "Kami akan bantu untuk hubungi dinas terkait",
            ),
            const SizedBox(
              height: spaceHuge,
            ),
            PrimaryButton(
                () {},
              "btn_close".tr(),
            ),
          ],
        ),
      ),
    );
  }
}