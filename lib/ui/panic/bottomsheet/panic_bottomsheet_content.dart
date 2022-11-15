import 'package:amirta_mobile/data/pengaduan/pengaduan.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart';

class PanicBottomSheetContent extends StatefulWidget {
  final Pengaduan pengaduan;

  const PanicBottomSheetContent(this.pengaduan, {Key? key}) : super(key: key);

  @override
  _PanicBottomSheetContentState createState() =>
      _PanicBottomSheetContentState();
}

class _PanicBottomSheetContentState extends State<PanicBottomSheetContent> {
  GoogleMapController? mapController;

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
                    widget.pengaduan.complainantName,
                    style: context.styleBody1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.pengaduan.rusunName,
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
                value: widget.pengaduan.rusunName,
              ),
            ),
            Expanded(
              flex: 3,
              child: TitleValueBox(
                title: 'txt_phone_num'.tr(),
                value: widget.pengaduan.complaintNumber,
              ),
            ),
            Expanded(
              flex: 2,
              child: TitleValueBox(
                title: 'txt_time'.tr(),
                value: widget.pengaduan.receivedDtimeFormatted,
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
              flex: 2,
              child: TitleValueBox(
                title: 'txt_blok'.tr(),
                value: widget.pengaduan.buildingName,
              ),
            ),
            Expanded(
              flex: 2,
              child: TitleValueBox(
                title: 'txt_lantai'.tr(),
                value: widget.pengaduan.floor.toString(),
              ),
            ),
            Expanded(
              flex: 2,
              child: TitleValueBox(
                title: 'txt_nomor'.tr(),
                value: widget.pengaduan.unitNumber,
              ),
            ),
            Expanded(
              flex: 2,
              child: TitleValueBox(
                title: 'txt_hour'.tr(),
                value: widget.pengaduan.receivedDtimeHourOnly,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: spaceMedium,
        ),
        SizedBox(
          height: 250,
          child: Builder(builder: (context) {
            final latlng =
                widget.pengaduan.latlng!.split(",").map((e) => double.parse(e));
            final position = LatLng(latlng.first, latlng.last);

            return GoogleMap(
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              compassEnabled: false,
              myLocationButtonEnabled: false,
              mapToolbarEnabled: false,
              markers: {
                Marker(
                  markerId: MarkerId(widget.pengaduan.id.toString()),
                  position: position,
                )
              },
              initialCameraPosition: CameraPosition(
                target: position,
                zoom: 15.4746,
              ),
              onMapCreated: (mapController) {
                this.mapController = mapController;
              },
            );
          }),
        ),
        const SizedBox(
          height: spaceMedium,
        ),
        DottedBorder(
          color: forest,
          radius: const Radius.circular(cardRadius),
          borderType: BorderType.RRect,
          child: InkWell(
            onTap: () async {
              final availableMaps = await MapLauncher.installedMaps;
              final latlng = widget.pengaduan.latlng!
                  .split(",")
                  .map((e) => double.parse(e));
              await availableMaps.first.showMarker(
                coords: Coords(latlng.first, latlng.last),
                title: "txt_accident_location".tr(),
                zoom: 21,
              );
            },
            child: Container(
              color: forest.withOpacity(0.02),
              height: 52,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.map_outlined,
                    color: forest,
                  ),
                  const SizedBox(
                    width: spaceNormal,
                  ),
                  Text(
                    'txt_accident_location'.tr(),
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
