import 'package:amirta_mobile/data/pengaduan/pengaduan.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/ui/dialog/photo_viewer_dialog.dart';

class ComplaintBottomSheetContent extends StatelessWidget {
  final Pengaduan pengaduan;

  const ComplaintBottomSheetContent(this.pengaduan);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: imgSizeMedium,
              height: imgSizeMedium,
              padding: const EdgeInsets.all(spaceTiny),
              child: Image.asset(
                imageRes('ic_complaint.png'),
                color: white,
              ),
              decoration: BoxDecoration(
                color: forest,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            const SizedBox(
              width: spaceNormal,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pengaduan.title,
                    style: context.styleBody1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    pengaduan.rusunName,
                    style: context.styleCaption,
                  ),
                ],
              ),
            ),
            StatusChip(
              done: false,
              notDoneText: 'Sarpas',
            ),
          ],
        ),
        const SizedBox(
          height: spaceNormal,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: TitleValueBox(
                title: 'txt_blok'.tr(),
                value: pengaduan.buildingName,
              ),
            ),
            Expanded(
              flex: 3,
              child: TitleValueBox(
                title: 'txt_lantai'.tr(),
                value: pengaduan.floor.toString(),
              ),
            ),
            Expanded(
              flex: 2,
              child: TitleValueBox(
                title: 'txt_nomor'.tr(),
                value: pengaduan.unitNumber,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: spaceNormal,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: TitleValueBox(
                title: 'txt_name'.tr(),
                value: pengaduan.complainantName,
              ),
            ),
            Expanded(
              flex: 3,
              child: TitleValueBox(
                title: 'txt_phone_num'.tr(),
                value: pengaduan.complaintNumber,
              ),
            ),
            Expanded(
              flex: 2,
              child: TitleValueBox(
                title: 'txt_time'.tr(),
                value: pengaduan.receivedDtimeFormatted,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: spaceNormal,
        ),
        TitleValueBox(
          title: 'txt_complaint_desc'.tr(),
          value: pengaduan.content,
        ),
        Visibility(
          visible: pengaduan.fname.isNotEmpty,
          child: Column(
            children: [
              const SizedBox(
                height: spaceNormal,
              ),
              Text(
                "txt_attachment".tr(),
                style: context.styleCaption,
              ),
              const SizedBox(
                height: spaceTiny,
              ),
              SizedBox(
                height: imgSizeBig,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 1,
                  itemBuilder: (context, position) {
                    return Padding(
                      padding: const EdgeInsets.only(right: spaceNormal),
                      child: SizedBox(
                        width: imgSizeBig,
                        height: imgSizeBig,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(cardRadius),
                          child: InkWell(
                            child: Image.network(
                              pengaduan.fname.imageUrl,
                              width: imgSizeBig,
                              height: imgSizeBig,
                              fit: BoxFit.cover,
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return PhotoViewerDialog(
                                      pengaduan.fname.imageUrl);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: spaceTiny,
              ),
              Text(
                "txt_tap_enlarge".tr(),
                style: context.styleCaption.copyWith(
                  color: accentColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
