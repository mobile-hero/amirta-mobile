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
  _WaterInputDoneBottomSheetState createState() =>
      _WaterInputDoneBottomSheetState();
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
                    title: 'txt_indicator_condition'.tr(),
                    value:
                        isConditionGood ? 'txt_good'.tr() : 'txt_broken'.tr(),
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
                title: 'txt_number_water_meter'.tr(),
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
                    title: 'txt_name'.tr(),
                    value: 'Asniar',
                  ),
                ),
                Expanded(
                  child: TitleValueBox(
                    title: 'txt_rusun'.tr(),
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
                    title: 'txt_blok'.tr(),
                    value: 'Blok G',
                  ),
                ),
                Expanded(
                  child: TitleValueBox(
                    title: 'txt_lantai'.tr(),
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
                    title: 'txt_nomor'.tr(),
                    value: '150',
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'txt_status'.tr(),
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
                'txt_notes'.tr(),
                style: context.styleCaption,
              ),
            ),
            LabeledInputField(
              noteController,
              label: 'hint_notes'.tr(),
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                'txt_photo_meter'.tr(),
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
                      'txt_photo_electric_meter'.tr(),
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
              'btn_save_data'.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
