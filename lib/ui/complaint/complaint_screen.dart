import 'package:amirta_mobile/bloc/complaint/list/complaint_list_bloc.dart';
import 'package:amirta_mobile/bloc/complaint/list/complaint_types_bloc.dart';
import 'package:amirta_mobile/data/pengaduan/pengaduan.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/ui/complaint/bottomsheet/complaint_detail_bottomsheet.dart';
import 'package:amirta_mobile/ui/complaint/complaint_appbar.dart';
import 'package:amirta_mobile/ui/complaint/complaint_customer_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({Key? key}) : super(key: key);

  @override
  _ComplaintScreenState createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ComplaintNewBloc(context.appProvider().pengaduanRepository);
      },
      child: Scaffold(
        appBar: ComplaintAppBar(
          enableLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.complaintHistory);
              },
              icon: ImageIcon(
                AssetImage(
                  imageRes('ic_history_pengaduan.png'),
                ),
              ),
            ),
          ],
        ),
        body: OfflineContainer(
          child: BlocBuilder<ComplaintNewBloc, ComplaintListState>(
            builder: (context, state) {
              final bloc = context.read<ComplaintNewBloc>();
              if (state is ComplaintListError) {
                return ErrorContainer(
                  onTap: () {
                    bloc.add(LoadComplaint.newItem);
                  },
                );
              }
              return RefreshIndicator(
                onRefresh: () async => bloc.pagingController.refresh(),
                child: PagedListView<int, Pengaduan>(
                  padding: const EdgeInsets.all(spaceMedium),
                  pagingController: bloc.pagingController,
                  builderDelegate: PagedChildBuilderDelegate(
                    itemBuilder: (context, item, position) {
                      return ComplaintCustomerItem(
                        item: item,
                        onTap: () async {
                          final bool? result =
                              await context.showScrollableBottomSheet<bool>(
                            builder: (context, scrollController) {
                              return ComplaintDetailBottomSheet(
                                  item, scrollController);
                            },
                          );
                          if (result != null) {
                            if (result) {
                              context.showCustomToast(
                                type: CustomToastType.success,
                                message: 'txt_complaint_handled'.tr(),
                              );
                            } else {
                              context.showCustomToast(
                                type: CustomToastType.error,
                                message: 'txt_complaint_rejected'.tr(),
                              );
                            }
                            bloc.pagingController.refresh();
                          }
                        },
                      );
                    },
                    noMoreItemsIndicatorBuilder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(spaceNormal),
                        child: Center(
                          child: Text(
                            'txt_no_more_complaint'.tr(),
                            style: context.styleCaption,
                          ),
                        ),
                      );
                    },
                    noItemsFoundIndicatorBuilder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(spaceNormal),
                        child: Center(
                          child: Text(
                            'txt_no_new_complaint'.tr(),
                            style: context.styleCaption,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
