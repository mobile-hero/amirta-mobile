import 'dart:io';

import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/ui/complaint/complaint_customer_item.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';

class CreateComplaintReportScreen extends StatefulWidget {
  @override
  _CreateComplaintReportScreenState createState() =>
      _CreateComplaintReportScreenState();
}

class _CreateComplaintReportScreenState
    extends State<CreateComplaintReportScreen> {
  final noteController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  final List<XFile> images = [];

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laporan Pengaduan'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Text(
                "txt_create_complaint_desc".tr(),
                style: context.styleCaption,
              ),
            ),
            const SizedBox(
              height: spaceNormal,
            ),
            ComplaintCustomerItem(),
            const SizedBox(
              height: spaceNormal,
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                'txt_report_note'.tr(),
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
            const SizedBox(
              height: spaceNormal,
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                'txt_accident_photos'.tr(),
                style: context.styleCaption,
              ),
            ),
            _createImagePickerButton(context),
            Center(
              child: Text(
                'txt_min_report_photo'.tr(),
                style: context.styleCaption,
              ),
            ),
            const SizedBox(
              height: spaceHuge,
            ),
            PrimaryButton(
              () {},
              'btn_create_report'.tr(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createImagePickerButton(BuildContext context) {
    final size = buttonDefaultHeight + spaceSmall;
    return SizedBox(
      height: size,
      width: double.infinity,
      child: Builder(
        builder: (context) {
          if (images.isNotEmpty) {
            return ListView.builder(
              itemCount: images.length + 1,
              itemBuilder: (context, position) {
                if (position <= images.length) {
                  return Padding(
                    padding: const EdgeInsets.only(right: spaceNormal),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(buttonRadius),
                          child: Image.file(
                            File(images[position].path),
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
                                  images.removeAt(position);
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
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.only(right: spaceMedium),
                  child: DottedBorder(
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
                              images.add(result);
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
                  ),
                );
              },
            );
          }
          return DottedBorder(
            radius: Radius.circular(buttonRadius),
            borderType: BorderType.RRect,
            color: borderColor,
            child: SizedBox(
              height: size,
              width: double.infinity,
              child: InkWell(
                onTap: () async {
                  final result = await _picker.pickImage(
                    source: ImageSource.camera,
                  );
                  if (result != null) {
                    final path = result.path;
                    print(path);
                    setState(() {
                      images.add(result);
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
