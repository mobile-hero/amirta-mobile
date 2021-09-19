import 'package:amirta_mobile/data/pengaduan/pengaduan.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/res/resources.dart';
import 'package:amirta_mobile/ui/complaint/bottomsheet/complaint_bottomsheet_content.dart';
import 'package:amirta_mobile/ui/complaint/dialog/complaint_set_complete_dialog.dart';
import 'package:slide_to_act/slide_to_act.dart';

class ComplaintInProcessBottomSheet extends StatelessWidget {
  final Pengaduan pengaduan;
  final ScrollController scrollController;
  final GlobalKey<SlideActionState> slideKey = GlobalKey();

  ComplaintInProcessBottomSheet(this.pengaduan, this.scrollController);

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
                  color: carrot.withOpacity(0.2),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: carrot,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.access_time_sharp,
                        color: white,
                        size: spaceMedium,
                      ),
                    ),
                    const SizedBox(
                      width: spaceTiny,
                    ),
                    Text(
                      "txt_complaint_in_process".tr(),
                      style: context.styleBody1.copyWith(
                        fontWeight: FontWeight.w600,
                        color: carrot,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: spaceMedium,
            ),
            /*TitleValueBox(
              title: "txt_action_note".tr(),
              value: "Kami akan bantu untuk hubungi dinas terkait",
            ),
            const SizedBox(
              height: spaceHuge,
            ),*/
            SlideAction(
              key: slideKey,
              height: 52,
              elevation: 0,
              outerColor: egyptian2,
              innerColor: white,
              text: "txt_swipe_to_complete".tr(),
              textStyle: context.styleBody1.copyWith(
                fontWeight: FontWeight.bold,
                color: white,
              ),
              sliderButtonIconPadding: spaceTiny,
              onSubmit: () async {
                final result = await showDialog(
                  context: context,
                  builder: (context) {
                    return ComplaintSetCompleteDialog();
                  },
                );
                if (result != null) {
                  Navigator.pop(context, pengaduan);
                } else {
                  slideKey.currentState?.reset();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
