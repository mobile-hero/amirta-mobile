import 'package:amirta_mobile/bloc/complaint/list/complaint_list_bloc.dart';
import 'package:amirta_mobile/bloc/complaint/list/complaint_types_bloc.dart';
import 'package:amirta_mobile/data/pengaduan/pengaduan_export.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/ui/complaint/bottomsheet/complaint_completed_bottomsheet.dart';
import 'package:amirta_mobile/ui/complaint/bottomsheet/complaint_inprocess_bottomsheet.dart';
import 'package:amirta_mobile/ui/complaint/bottomsheet/complaint_rejected_bottomsheet.dart';
import 'package:amirta_mobile/ui/complaint/complaint_customer_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ComplaintHistoryScreen extends StatefulWidget {
  @override
  _ComplaintHistoryScreenState createState() => _ComplaintHistoryScreenState();
}

class _ComplaintHistoryScreenState extends State<ComplaintHistoryScreen> {
  int tabPosition = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pengaduanRepository = context.appProvider().pengaduanRepository;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return ComplaintInProcessBloc(pengaduanRepository);
        }),
        BlocProvider(create: (context) {
          return ComplaintRejectedBloc(pengaduanRepository);
        }),
        BlocProvider(create: (context) {
          return ComplaintCompletedBloc(pengaduanRepository);
        }),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('title_history_complaint'.tr()),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: OfflineContainer(
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                Container(
                  color: egyptian,
                  child: TabBar(
                    tabs: [
                      Tab(
                        text: 'tab_processing'.tr(),
                      ),
                      Tab(
                        text: 'tab_rejected'.tr(),
                      ),
                      Tab(
                        text: 'tab_completed'.tr(),
                      ),
                    ],
                    labelStyle: context.styleCaption.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    labelColor: white,
                    unselectedLabelStyle: context.styleCaption.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelColor: white.withOpacity(0.5),
                    indicatorPadding: const EdgeInsets.symmetric(
                      horizontal: spaceHuge + spaceMedium,
                    ),
                    indicatorColor: waterfall,
                    onTap: (value) {
                      setState(() {
                        tabPosition = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      BlocBuilder<ComplaintInProcessBloc, ComplaintListState>(
                          builder: (context, state) {
                        return _contentView(
                          context.read<ComplaintInProcessBloc>().pagingController,
                          ComplaintCustomerItemType.neutral,
                          "txt_no_complaint_in_process".tr(),
                          (value) async {
                            final result = await context
                                .showScrollableBottomSheet<Pengaduan>(
                              builder: (context, scrollController) {
                                return ComplaintInProcessBottomSheet(
                                    value, scrollController);
                              },
                            );
                            if (result != null) {
                              final response = await Navigator.pushNamed(
                                context,
                                Routes.complaintSetComplete,
                                arguments: result,
                              );
                              if (response != null) {
                                context
                                    .read<ComplaintInProcessBloc>()
                                    .pagingController
                                    .refresh();

                                context.showCustomToast(
                                  type: CustomToastType.success,
                                  message: "txt_complaint_completed".tr(),
                                );
                              }
                            }
                          },
                        );
                      }),
                      BlocBuilder<ComplaintRejectedBloc, ComplaintListState>(
                          builder: (context, state) {
                        return _contentView(
                          context.read<ComplaintRejectedBloc>().pagingController,
                          ComplaintCustomerItemType.rejected,
                          "txt_no_complaint_rejected".tr(),
                          (value) async {
                            final result =
                                await context.showScrollableBottomSheet<int>(
                              builder: (context, scrollController) {
                                return ComplaintRejectedBottomSheet(
                                    value, scrollController);
                              },
                            );
                            if (result != null) {
                              context
                                  .read<ComplaintRejectedBloc>()
                                  .pagingController
                                  .refresh();
                            }
                          },
                        );
                      }),
                      BlocBuilder<ComplaintCompletedBloc, ComplaintListState>(
                          builder: (context, state) {
                        return _contentView(
                          context.read<ComplaintCompletedBloc>().pagingController,
                          ComplaintCustomerItemType.completed,
                          "txt_no_complaint_completed".tr(),
                          (value) async {
                            final result =
                                await context.showScrollableBottomSheet<int>(
                              builder: (context, scrollController) {
                                return ComplaintCompletedBottomSheet(
                                    value, scrollController);
                              },
                            );
                            if (result != null) {
                              context
                                  .read<ComplaintCompletedBloc>()
                                  .pagingController
                                  .refresh();
                            }
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _contentView(
    PagingController<int, Pengaduan> pagingController,
    ComplaintCustomerItemType type,
    String emptyMessage,
    Function(Pengaduan) onTap,
  ) {
    return RefreshIndicator(
      onRefresh: () async => pagingController.refresh(),
      child: PagedListView<int, Pengaduan>(
        padding: const EdgeInsets.all(spaceMedium),
        pagingController: pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: (context, item, position) {
            return ComplaintCustomerItem(
              item: item,
              type: type,
              onTap: () => onTap.call(item),
            );
          },
          noItemsFoundIndicatorBuilder: (context) {
            return Padding(
              padding: const EdgeInsets.all(spaceNormal),
              child: Center(
                child: Text(
                  emptyMessage,
                  style: context.styleCaption,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
