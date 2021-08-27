import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/res/resources.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';

class WaterInputDoneBottomSheet extends StatefulWidget {
  final ScrollController scrollController;

  const WaterInputDoneBottomSheet({
    required this.scrollController,
  });

  @override
  _WaterInputDoneBottomSheetState createState() => _WaterInputDoneBottomSheetState();
}

class _WaterInputDoneBottomSheetState extends State<WaterInputDoneBottomSheet> {
  bool isConditionGood = true;
  final noteController = TextEditingController();
  final numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.scrollController,
      padding: const EdgeInsets.all(spaceBig),
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TitleValueBox(
                    title: 'Kondisi Meteran',
                    value: isConditionGood ? 'Baik' : 'Rusak',
                  ),
                ),
                CupertinoSwitch(
                  value: isConditionGood,
                  onChanged: (value) {
                    setState(() {
                      isConditionGood = value;
                    });
                  },
                  activeColor: waterfall,
                  // inactiveTrackColor: carrot,
                ),
              ],
            ),
            const SizedBox(
              height: spaceNormal,
            ),
            SizedBox(
              width: double.infinity,
              child: TitleValueBox(
                title: 'Angka Meter Air',
                value: '00305',
              ),
            ),
            const SizedBox(
              height: spaceNormal,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TitleValueBox(
                    title: 'Nama',
                    value: 'Asniar',
                  ),
                ),
                Expanded(
                  child: TitleValueBox(
                    title: 'Rusun',
                    value: 'Rusun Karang Anyar',
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
                  child: TitleValueBox(
                    title: 'Blok',
                    value: 'Blok G',
                  ),
                ),
                Expanded(
                  child: TitleValueBox(
                    title: 'Lantai',
                    value: '8',
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
                  child: TitleValueBox(
                    title: 'Nomor',
                    value: '150',
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Status',
                        style: context.styleCaption,
                      ),
                      StatusChip(done: true),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: spaceNormal,
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                'Catatan (opsional)',
                style: context.styleCaption,
              ),
            ),
            LabeledInputField(
              noteController,
              label: 'Tulis catatan disini',
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                'Foto Meteran',
                style: context.styleCaption,
              ),
            ),
            const SizedBox(
              height: spaceTiny,
            ),
            SizedBox(
              height: buttonDefaultHeight,
              width: double.infinity,
              child: DottedBorder(
                radius: Radius.circular(buttonRadius),
                borderType: BorderType.RRect,
                padding: const EdgeInsets.all(spaceNormal),
                color: borderColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      imageRes('ic_camera.png'),
                    ),
                    const SizedBox(
                      width: spaceNormal,
                    ),
                    Text(
                      'Foto Meteran Listrik',
                      style: context.styleCaption,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: spaceBig,
            ),
            PrimaryButton(
              () {
                Navigator.pop(context);
              },
              'Simpan Data',
            ),
          ],
        ),
      ),
    );
  }
}
