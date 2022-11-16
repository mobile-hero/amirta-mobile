import 'package:amirta_mobile/data/pengaduan/pengaduan.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/ui/complaint/bottomsheet/complaint_bottomsheet_content.dart';
import 'package:amirta_mobile/ui/complaint/dialog/complaint_accept_dialog.dart';
import 'package:amirta_mobile/ui/complaint/dialog/complaint_reject_dialog.dart';

class ComplaintDetailBottomSheet extends StatelessWidget {
  final Pengaduan pengaduan;
  final ScrollController scrollController;

  const ComplaintDetailBottomSheet(this.pengaduan, this.scrollController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      padding: const EdgeInsets.all(spaceHuge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ComplaintBottomSheetContent(pengaduan),
          const SizedBox(
            height: spaceNormal,
          ),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  () async {
                    final result = await showDialog(
                      context: context,
                      builder: (context) {
                        return ComplaintAcceptDialog(pengaduan);
                      },
                    );
                    if (result != null) {
                      Navigator.pop(context, true);
                    }
                  },
                  'btn_take_action'.tr(),
                ),
              ),
              const SizedBox(
                width: spaceMedium,
              ),
              Expanded(
                child: SecondaryButton(
                  () async {
                    final result = await showDialog(
                      context: context,
                      builder: (context) {
                        return ComplaintRejectDialog(pengaduan);
                      },
                    );
                    if (result != null) {
                      Navigator.pop(context, false);
                    }
                  },
                  'btn_reject'.tr(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
