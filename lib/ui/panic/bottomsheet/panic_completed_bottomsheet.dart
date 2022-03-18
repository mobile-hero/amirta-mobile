import 'package:amirta_mobile/bloc/complaint/detail/complaint_detail_bloc.dart';
import 'package:amirta_mobile/data/pengaduan/pengaduan.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/res/resources.dart';
import 'package:amirta_mobile/ui/dialog/photo_viewer_dialog.dart';
import 'package:amirta_mobile/ui/panic/bottomsheet/panic_bottomsheet_content.dart';

class PanicCompletedBottomSheet extends StatelessWidget {
  final Pengaduan pengaduan;
  final ScrollController scrollController;

  const PanicCompletedBottomSheet(this.pengaduan, this.scrollController);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ComplaintDetailBloc(context.appProvider().pengaduanRepository)
          ..add(LoadComplaint(pengaduan.id));
      },
      child: SingleChildScrollView(
        controller: scrollController,
        padding: const EdgeInsets.all(spaceHuge),
        child: Container(
          child: BlocBuilder<ComplaintDetailBloc, ComplaintDetailState>(
            builder: (context, state) {
              if (state is ComplaintDetailSuccess) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PanicBottomSheetContent(pengaduan),
                    const SizedBox(
                      height: spaceMedium,
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(spaceTiny),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: forest.withOpacity(0.2),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(spaceTiny),
                              decoration: BoxDecoration(
                                color: forest,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.check_rounded,
                                color: white,
                                size: spaceMedium,
                              ),
                            ),
                            const SizedBox(
                              width: spaceTiny,
                            ),
                            Text(
                              "txt_panic_completed".tr(),
                              style: context.styleBody1.copyWith(
                                fontWeight: FontWeight.w600,
                                color: forest,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: spaceMedium,
                    ),
                    TitleValueBox(
                      title: "txt_report_note".tr(),
                      value: pengaduan.operatorNotes ?? "-",
                    ),
                    const SizedBox(
                      height: spaceNormal,
                    ),
                    Text(
                      "txt_on_duty_photos".tr(),
                      style: context.styleCaption,
                    ),
                    const SizedBox(
                      height: spaceTiny,
                    ),
                    SizedBox(
                      height: imgSizeBig,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.pengaduan.fileList!.length,
                        itemBuilder: (context, position) {
                          return Padding(
                            padding: const EdgeInsets.only(right: spaceNormal),
                            child: SizedBox(
                              width: imgSizeBig,
                              height: imgSizeBig,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(cardRadius),
                                child: InkWell(
                                  child: Image.network(
                                    state.pengaduan.fileList![position].fname
                                        .imageUrl,
                                    width: imgSizeBig,
                                    height: imgSizeBig,
                                    fit: BoxFit.cover,
                                  ),
                                  onTap: () {
                                    showPhotoViewerDialog(
                                      context: context,
                                      imageUrl: state.pengaduan
                                          .fileList![position].fname.imageUrl,
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: spaceTiny,
                    ),
                    Text(
                      "txt_tap_enlarge".tr(),
                      style: context.styleCaption.copyWith(
                        color: accentColor,
                      ),
                    ),
                    const SizedBox(
                      height: spaceHuge,
                    ),
                    PrimaryButton(
                      () {
                        Navigator.pop(context);
                      },
                      "btn_close".tr(),
                    ),
                  ],
                );
              }

              return Center(
                child: MyProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
