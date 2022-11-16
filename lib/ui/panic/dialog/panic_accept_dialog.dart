import 'package:amirta_mobile/bloc/complaint/create/complaint_create_bloc.dart';
import 'package:amirta_mobile/data/pengaduan/complaint_status.dart';
import 'package:amirta_mobile/data/pengaduan/pengaduan.dart';
import 'package:amirta_mobile/my_material.dart';

class PanicAcceptDialog extends StatefulWidget {
  final Pengaduan pengaduan;

  const PanicAcceptDialog(this.pengaduan, {Key? key}) : super(key: key);

  @override
  _PanicAcceptDialogState createState() => _PanicAcceptDialogState();
}

class _PanicAcceptDialogState extends State<PanicAcceptDialog> {
  final noteController = TextEditingController();

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ComplaintCreateBloc(
          context.appProvider().pengaduanRepository,
          context.appProvider().uploadImageRepository,
        );
      },
      child: Dialog(
        backgroundColor: white,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(spaceMedium)),
        insetPadding: const EdgeInsets.all(spaceMedium),
        child: Padding(
          padding: const EdgeInsets.all(spaceBig),
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'txt_receive_panic'.tr(),
                    style: context.styleBody1,
                  ),
                  // Align(
                  //   alignment: Alignment.centerLeft,
                  //   child: Text(
                  //     'txt_action_note'.tr(),
                  //     style: context.styleBody1.copyWith(
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: spaceNormal,
                  // ),
                  // LabeledInputField(
                  //   noteController,
                  //   label: 'hint_notes'.tr(),
                  //   padding: const EdgeInsets.only(bottom: spaceBig),
                  //   minLines: 3,
                  //   maxLength: 255,
                  //   onChanged: (value) {
                  //     setState(() {});
                  //   },
                  // ),
                  Visibility(
                    visible: state is! ComplaintCreateLoading,
                    replacement: const Center(
                      child: MyProgressIndicator(),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            () {
                              context.read<ComplaintCreateBloc>().add(
                                    AcceptPanic(
                                      pengaduanId: widget.pengaduan.id,
                                      status: ComplaintStatus.inProcess,
                                    ),
                                  );
                            },
                            'btn_confirm'.tr(),
                          ),
                        ),
                        const SizedBox(
                          width: spaceSmall,
                        ),
                        Expanded(
                          child: SecondaryButton(
                            () {
                              Navigator.pop(context);
                            },
                            'btn_cancel'.tr(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
