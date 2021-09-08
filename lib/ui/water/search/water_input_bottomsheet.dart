import 'dart:io';

import 'package:amirta_mobile/bloc/upload/upload_bloc.dart';
import 'package:amirta_mobile/bloc/water/add/water_add_report_bloc.dart';
import 'package:amirta_mobile/data/rusun/rusun_export.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/res/resources.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class WaterInputBottomSheet extends StatefulWidget {
  final ScrollController scrollController;
  final Rusun rusun;
  final RusunBlok rusunBlok;
  final RusunUnit rusunUnit;

  const WaterInputBottomSheet({
    required this.scrollController,
    required this.rusun,
    required this.rusunBlok,
    required this.rusunUnit,
  });

  @override
  _WaterInputBottomSheetState createState() => _WaterInputBottomSheetState();
}

class _WaterInputBottomSheetState extends State<WaterInputBottomSheet> {
  bool isConditionGood = true;
  final noteController = TextEditingController();
  final numberController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? selectedImage;

  @override
  void dispose() {
    isConditionGood = widget.rusunUnit.pdamMeterStatus == 0;
    noteController.dispose();
    numberController.dispose();
    super.dispose();
  }

  bool get enableSaveButton {
    return noteController.text.trim().isNotEmpty &&
        numberController.text.trim().isNotEmpty &&
        selectedImage != null;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return WaterAddReportBloc(context.appProvider().rusunRepository);
          },
        ),
        BlocProvider(
          create: (context) {
            return UploadBloc(context.appProvider().uploadImageRepository);
          },
        )
      ],
      child: BlocConsumer<WaterAddReportBloc, WaterAddReportState>(
        listener: (context, state) {
          if (state is WaterAddReportSuccess) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
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
                          value: isConditionGood
                              ? 'txt_good'.tr()
                              : 'txt_broken'.tr(),
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TitleValueBox(
                          title: 'txt_name'.tr(),
                          value: widget.rusunUnit.residentName ?? "-",
                        ),
                      ),
                      Expanded(
                        child: TitleValueBox(
                          title: 'txt_rusun'.tr(),
                          value: widget.rusun.name,
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
                          value: widget.rusunUnit.buildingName,
                        ),
                      ),
                      Expanded(
                        child: TitleValueBox(
                          title: 'txt_lantai'.tr(),
                          value: widget.rusunUnit.floor.toString(),
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
                          value: widget.rusunUnit.unitNumber,
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
                            StatusChip(done: false),
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
                    minLines: 3,
                    maxLength: 255,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: LabeledInputField(
                          numberController,
                          label: 'txt_input_water_meter'.tr(),
                          inputType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                      const SizedBox(
                        width: spaceNormal,
                      ),
                      _createImagePickerButton(context),
                    ],
                  ),
                  BlocConsumer<UploadBloc, UploadState>(
                    listener: (context, uploadState) {
                      if (uploadState is UploadSuccess) {
                        final dateTime = DateTime.now();
                        context.read<WaterAddReportBloc>().add(
                              AddReport(MeterDataWrite(
                                rusunId: widget.rusunUnit.rusunId,
                                buildingId: widget.rusunUnit.buildingId,
                                unitId: widget.rusunUnit.id,
                                month: dateTime.month,
                                year: dateTime.year.toString(),
                                meterType: 1,
                                meterValue: double.parse(numberController.text),
                                notes: noteController.text,
                                image: uploadState.url,
                              )),
                            );
                      }
                    },
                    builder: (context, uploadState) {
                      return PrimaryButton(
                        () {
                          context
                              .read<UploadBloc>()
                              .add(UploadImage(selectedImage!));
                        },
                        'btn_save_data'.tr(),
                        isEnabled: enableSaveButton,
                        isLoading: uploadState is UploadLoading ||
                            state is WaterAddReportLoading,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _createImagePickerButton(BuildContext context) {
    final size = buttonDefaultHeight + spaceSmall;
    return SizedBox(
      height: size,
      width: size,
      child: Builder(
        builder: (context) {
          if (selectedImage != null) {
            return Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(buttonRadius),
                  child: Image.file(
                    File(selectedImage!.path),
                    fit: BoxFit.cover,
                    height: size,
                    width: size,
                  ),
                ),
                Transform.translate(
                  offset: Offset(5, -5),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedImage = null;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(spaceTiny),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: white),
                          color: darkBackground,
                        ),
                        child: Icon(
                          Icons.clear,
                          color: white,
                          size: 10,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return DottedBorder(
            radius: Radius.circular(buttonRadius),
            borderType: BorderType.RRect,
            color: borderColor,
            child: SizedBox(
              height: size,
              width: size,
              child: InkWell(
                onTap: () async {
                  final result = await _picker.pickImage(
                    source: ImageSource.camera,
                  );
                  if (result != null) {
                    final path = result.path;
                    print(path);
                    setState(() {
                      selectedImage = result;
                    });
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(spaceNormal),
                  child: Image.asset(
                    imageRes('ic_camera.png'),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
