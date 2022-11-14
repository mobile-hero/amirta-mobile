import 'dart:io';

import 'package:amirta_mobile/bloc/upload/upload_bloc.dart';
import 'package:amirta_mobile/bloc/water/add/water_add_report_bloc.dart';
import 'package:amirta_mobile/data/rusun/rusun_export.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class WaterInputDoneBottomSheet extends StatefulWidget {
  final ScrollController scrollController;
  final RusunUnit rusunUnit;
  final int meterStatus;
  final double? lastMeterValue;
  final int month;
  final int year;

  const WaterInputDoneBottomSheet({
    required this.scrollController,
    required this.rusunUnit,
    required this.meterStatus,
    required this.lastMeterValue,
    required this.month,
    required this.year,
  });

  @override
  _WaterInputDoneBottomSheetState createState() =>
      _WaterInputDoneBottomSheetState();
}

class _WaterInputDoneBottomSheetState extends State<WaterInputDoneBottomSheet> {
  bool isConditionGood = true;
  final noteController = TextEditingController();
  final numberController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? selectedImage;

  @override
  void initState() {
    isConditionGood = widget.meterStatus == 0;
    numberController.text = widget.lastMeterValue?.toStringAsFixed(0) ?? '-';
    noteController.text = "txt_periode_recorded"
        .tr(args: [widget.month.toString(), widget.year.toString()]);
    super.initState();
  }

  @override
  void dispose() {
    noteController.dispose();
    numberController.dispose();
    super.dispose();
  }

  bool get enableSaveButton {
    if (isConditionGood) {
      return numberController.text.trim().isNotEmpty && selectedImage != null;
    } else {
      return selectedImage != null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return WaterAddReportBloc(
              context.appProvider().rusunRepository,
              context.appProvider().connectivity,
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return UploadBloc(
              context.appProvider().uploadImageRepository,
              context.appProvider().connectivity,
            );
          },
        )
      ],
      child: BlocConsumer<WaterAddReportBloc, WaterAddReportState>(
        listener: (context, state) {
          if (state is WaterAddReportSuccess) {
            context.showCustomToast(
              type: CustomToastType.success,
              message: "txt_data_saved".tr(),
            );
            Navigator.pop(context);
          }
          if (state is WaterAddReportSuccessLocal) {
            context.showCustomToast(
              type: CustomToastType.success,
              message: "txt_data_saved_local".tr(),
            );
            Navigator.pop(context);
          }
          if (state is WaterAddReportError) {
            context.showCustomToast(
              type: CustomToastType.error,
              message: state.errorMessage,
            );
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
                            numberController.text = "";
                          });
                        },
                        activeColor: waterfall,
                        trackColor: carrot,
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
                      value: widget.lastMeterValue?.toStringAsFixed(0) ?? "",
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
                          value: widget.rusunUnit.residentName ?? "-",
                        ),
                      ),
                      Expanded(
                        child: TitleValueBox(
                          title: 'txt_rusun'.tr(),
                          value: widget.rusunUnit.rusunName,
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
                          isEnabled: isConditionGood,
                          backgroundColor:
                              isConditionGood ? null : inputDisabledColor,
                        ),
                      ),
                      const SizedBox(
                        width: spaceNormal,
                      ),
                      _createImagePickerButton(context),
                    ],
                  ),
                  const SizedBox(
                    height: spaceBig,
                  ),
                  BlocConsumer<UploadBloc, UploadState>(
                    listener: (context, uploadState) {
                      if (uploadState is UploadSuccess) {
                        context.read<WaterAddReportBloc>().add(
                              AddReport(
                                isConditionGood,
                                MeterDataWrite(
                                  rusunId: widget.rusunUnit.rusunId,
                                  buildingId: widget.rusunUnit.buildingId,
                                  unitId: widget.rusunUnit.id,
                                  month: widget.month,
                                  year: widget.year.toString(),
                                  meterType: 1,
                                  meterValue:
                                      double.tryParse(numberController.text) ??
                                          0,
                                  notes: isConditionGood
                                      ? noteController.text.trim()
                                      : "",
                                  statusNote: isConditionGood
                                      ? null
                                      : noteController.text.trim(),
                                  status: isConditionGood ? 0 : 1,
                                  image: uploadState.url,
                                ),
                              ),
                            );
                      }
                      if (uploadState is UploadOffline) {
                        context.read<WaterAddReportBloc>().add(
                              AddReportOffline(
                                isConditionGood,
                                MeterDataWrite(
                                  rusunId: widget.rusunUnit.rusunId,
                                  buildingId: widget.rusunUnit.buildingId,
                                  unitId: widget.rusunUnit.id,
                                  month: widget.month,
                                  year: widget.year.toString(),
                                  meterType: 1,
                                  meterValue:
                                      double.tryParse(numberController.text) ??
                                          0,
                                  notes: isConditionGood
                                      ? noteController.text.trim()
                                      : "",
                                  statusNote: isConditionGood
                                      ? null
                                      : noteController.text.trim(),
                                  status: isConditionGood ? 0 : 1,
                                  image: null,
                                )..photoBase64 = uploadState.base64,
                              ),
                            );
                      }
                    },
                    builder: (context, uploadState) {
                      return PrimaryButton(
                        () async {
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
