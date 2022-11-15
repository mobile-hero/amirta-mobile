import 'package:amirta_mobile/data/pengaduan/pengaduan.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/ui/panic/bottomsheet/panic_bottomsheet_content.dart';
import 'package:amirta_mobile/ui/panic/dialog/panic_accept_dialog.dart';
import 'package:amirta_mobile/ui/panic/dialog/panic_reject_dialog.dart';

class PanicDetailBottomSheet extends StatelessWidget {
  final Pengaduan pengaduan;
  final ScrollController scrollController;

  const PanicDetailBottomSheet(
    this.pengaduan,
    this.scrollController, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      padding: const EdgeInsets.all(spaceHuge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PanicBottomSheetContent(pengaduan),
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
                        return PanicAcceptDialog(pengaduan);
                      },
                    );
                    if (result != null) {
                      Navigator.pop(context, true);
                    }
                  },
                  "btn_ready_action".tr(),
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
                        return PanicRejectDialog(pengaduan);
                      },
                    );
                    if (result != null) {
                      Navigator.pop(context, false);
                    }
                  },
                  "btn_out_of_reach".tr(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
