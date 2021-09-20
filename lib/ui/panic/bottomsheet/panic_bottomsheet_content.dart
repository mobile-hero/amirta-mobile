import 'package:amirta_mobile/data/pengaduan/pengaduan.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:map_launcher/map_launcher.dart';

class PanicBottomSheetContent extends StatelessWidget {
  final Pengaduan pengaduan;

  const PanicBottomSheetContent(this.pengaduan);

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
                imageRes('ic_alert.png'),
                color: white,
                height: spaceMedium,
              ),
              decoration: BoxDecoration(
                color: scarlet,
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
                    pengaduan.complainantName,
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
                title: 'txt_rusun'.tr(),
                value: pengaduan.rusunName,
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
          height: spaceMedium,
        ),
        DottedBorder(
          color: forest,
          radius: Radius.circular(cardRadius),
          borderType: BorderType.RRect,
          child: InkWell(
            onTap: () async {
              final availableMaps = await MapLauncher.installedMaps;
              final latlng = pengaduan.latlng.split(",").map((e) => double.parse(e));
              await availableMaps.first.showMarker(
                coords: Coords(latlng.first, latlng.last),
                title: "Lokasi Kejadian",
                zoom: 21,
              );
            },
            child: Container(
              color: forest.withOpacity(0.02),
              height: 52,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map_outlined,
                    color: forest,
                  ),
                  const SizedBox(
                    width: spaceNormal,
                  ),
                  Text(
                    'Lokasi Kejadian',
                    style: context.styleBody1.copyWith(
                      fontWeight: FontWeight.bold,
                      color: forest,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: spaceMedium,
        ),
      ],
    );
  }
}
