import 'package:amirta_mobile/data/pengaduan/pengaduan.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/res/resources.dart';
import 'package:amirta_mobile/ui/complaint/bottomsheet/complaint_bottomsheet_content.dart';

class ComplaintRejectedBottomSheet extends StatelessWidget {
  final Pengaduan pengaduan;
  final ScrollController scrollController;

  const ComplaintRejectedBottomSheet(this.pengaduan, this.scrollController);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      padding: const EdgeInsets.all(spaceHuge),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ComplaintBottomSheetContent(pengaduan),
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
              value: pengaduan.operatorNotes ?? "-",
            ),
            const SizedBox(
              height: spaceHuge,
            ),
            PrimaryButton(
              () {
                Navigator.pop(context);
              },
              "btn_close".tr(),
            ),
          ],
        ),
      ),
    );
  }
}
