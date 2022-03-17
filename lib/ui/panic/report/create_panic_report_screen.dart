import 'dart:io';

import 'package:amirta_mobile/bloc/complaint/create/complaint_create_bloc.dart';
import 'package:amirta_mobile/data/pengaduan/complaint_status.dart';
import 'package:amirta_mobile/data/pengaduan/pengaduan.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/ui/complaint/complaint_customer_item.dart';
import 'package:amirta_mobile/ui/panic/panic_customer_item.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';

class CreatePanicReportScreen extends StatefulWidget {
  @override
  _CreatePanicReportScreenState createState() =>
      _CreatePanicReportScreenState();
}

class _CreatePanicReportScreenState
    extends State<CreatePanicReportScreen> {
  final noteController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  final List<XFile> images = [];

  late Pengaduan pengaduan;

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    pengaduan = ModalRoute.of(context)?.settings.arguments as Pengaduan;
    return BlocProvider(
      create: (context) {
        return ComplaintCreateBloc(
          context.appProvider().pengaduanRepository,
          context.appProvider().uploadImageRepository,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Laporan Panik'),
          titleTextStyle: context.styleHeadline5,
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(spaceMedium),
          child: BlocConsumer<ComplaintCreateBloc, ComplaintCreateState>(
            listener: (context, state) {
              if (state is ComplaintCreateSuccess) {
                Navigator.pop(context, true);
              } else if (state is ComplaintCreateError) {
                context.showCustomToast(
                  type: CustomToastType.error,
                  message: state.message,
                );
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  Center(
                    child: Text(
                      "txt_create_panic_desc".tr(),
                      style: context.styleCaption,
                    ),
                  ),
                  const SizedBox(
                    height: spaceNormal,
                  ),
                  PanicCustomerItem(item: pengaduan),
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
                  const SizedBox(
                    height: spaceNormal,
                  ),
                  _createImagePickerButton(
                      context, state is ComplaintCreateLoading),
                  const SizedBox(
                    height: spaceNormal,
                  ),
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
                    () {
                      context.read<ComplaintCreateBloc>().add(CreateComplaint(
                            pengaduanId: pengaduan.id,
                            status: ComplaintStatus.completed,
                            notes: noteController.text,
                            images: images,
                          ));
                    },
                    'btn_create_report'.tr(),
                    isEnabled:
                        noteController.text.isNotEmpty && images.length >= 1,
                    isLoading: state is ComplaintCreateLoading,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _createImagePickerButton(BuildContext context, bool isLoading) {
    final size = buttonDefaultHeight + spaceSmall;
    return SizedBox(
      height: size,
      width: double.infinity,
      child: Builder(
        builder: (context) {
          if (images.isNotEmpty) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length + 1,
              itemBuilder: (context, position) {
                if (position < images.length) {
                  return Padding(
                    padding: const EdgeInsets.only(right: spaceNormal),
                    child: SizedBox(
                      height: size,
                      width: size,
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
                          Visibility(
                            visible: !isLoading,
                            child: Transform.translate(
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
                          ),
                        ],
                      ),
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
