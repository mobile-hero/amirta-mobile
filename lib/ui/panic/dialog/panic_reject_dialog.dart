import 'package:amirta_mobile/bloc/complaint/create/complaint_create_bloc.dart';
import 'package:amirta_mobile/data/pengaduan/complaint_status.dart';
import 'package:amirta_mobile/data/pengaduan/pengaduan.dart';
import 'package:amirta_mobile/my_material.dart';

class PanicRejectDialog extends StatefulWidget {
  final Pengaduan pengaduan;

  const PanicRejectDialog(this.pengaduan);

  @override
  _PanicRejectDialogState createState() => _PanicRejectDialogState();
}

class _PanicRejectDialogState extends State<PanicRejectDialog> {
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
          }, builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'txt_panic_rejection_note'.tr(),
                    style: context.styleBody1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: spaceNormal,
                ),
                LabeledInputField(
                  noteController,
                  label: 'hint_notes'.tr(),
                  padding: const EdgeInsets.only(bottom: spaceBig),
                  minLines: 3,
                  maxLength: 255,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                Visibility(
                  visible: !(state is ComplaintCreateLoading),
                  replacement: Center(
                    child: MyProgressIndicator(),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          () {
                            context.read<ComplaintCreateBloc>().add(
                                  CreateComplaint(
                                    pengaduanId: widget.pengaduan.id,
                                    status: ComplaintStatus.rejected,
                                    notes: noteController.text,
                                  ),
                                );
                          },
                          "btn_confirm".tr(),
                          isEnabled: noteController.text.isNotEmpty,
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
                          "btn_cancel".tr(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
