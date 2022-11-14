import 'package:amirta_mobile/bloc/complaint/detail/complaint_detail_bloc.dart';
import 'package:amirta_mobile/data/pengaduan/pengaduan.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/ui/complaint/bottomsheet/complaint_bottomsheet_content.dart';
import 'package:amirta_mobile/ui/dialog/photo_viewer_dialog.dart';

class ComplaintCompletedBottomSheet extends StatelessWidget {
  final Pengaduan pengaduan;
  final ScrollController scrollController;

  const ComplaintCompletedBottomSheet(this.pengaduan, this.scrollController);

  final image =
      'https://cdn11.bigcommerce.com/s-gobnp3073t/images/stencil/1280x1280/products/3864/12342/apigjlste__34068.1609247181.jpg?c=2';

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
                    ComplaintBottomSheetContent(pengaduan),
                    const SizedBox(
                      height: spaceBig,
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
                              "txt_complaint_completed".tr(),
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
