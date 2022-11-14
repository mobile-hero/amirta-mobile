import 'package:amirta_mobile/bloc/complaint/list/complaint_list_bloc.dart';
import 'package:amirta_mobile/bloc/complaint/list/panic_types_bloc.dart';
import 'package:amirta_mobile/data/pengaduan/pengaduan_export.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/ui/panic/bottomsheet/panic_completed_bottomsheet.dart';
import 'package:amirta_mobile/ui/panic/bottomsheet/panic_inprocess_bottomsheet.dart';
import 'package:amirta_mobile/ui/panic/bottomsheet/panic_rejected_bottomsheet.dart';
import 'package:amirta_mobile/ui/panic/panic_customer_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PanicHistoryScreen extends StatefulWidget {
  @override
  _PanicHistoryScreenState createState() => _PanicHistoryScreenState();
}

class _PanicHistoryScreenState extends State<PanicHistoryScreen> {
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
          return PanicInProcessBloc(pengaduanRepository);
        }),
        BlocProvider(create: (context) {
          return PanicRejectedBloc(pengaduanRepository);
        }),
        BlocProvider(create: (context) {
          return PanicCompletedBloc(pengaduanRepository);
        }),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('title_history_panic'.tr()),
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
                      BlocBuilder<PanicInProcessBloc, ComplaintListState>(
                          builder: (context, state) {
                        return _contentView(
                          context.read<PanicInProcessBloc>().pagingController,
                          PanicCustomerItemType.neutral,
                          "txt_no_panic_in_process".tr(),
                          (value) async {
                            final result = await context
                                .showScrollableBottomSheet<Pengaduan>(
                              builder: (context, scrollController) {
                                return PanicInProcessBottomSheet(
                                    value, scrollController);
                              },
                            );
                            if (result != null) {
                              final response = await Navigator.pushNamed(
                                context,
                                Routes.panicSetComplete,
                                arguments: result,
                              );
                              if (response != null) {
                                context
                                    .read<PanicInProcessBloc>()
                                    .pagingController
                                    .refresh();

                                context.showCustomToast(
                                  type: CustomToastType.success,
                                  message: "txt_panic_completed".tr(),
                                );
                              }
                            }
                          },
                        );
                      }),
                      BlocBuilder<PanicRejectedBloc, ComplaintListState>(
                          builder: (context, state) {
                        return _contentView(
                          context.read<PanicRejectedBloc>().pagingController,
                          PanicCustomerItemType.rejected,
                          "txt_no_panic_rejected".tr(),
                          (value) async {
                            final result =
                                await context.showScrollableBottomSheet<int>(
                              builder: (context, scrollController) {
                                return PanicRejectedBottomSheet(
                                    value, scrollController);
                              },
                            );
                            if (result != null) {
                              context
                                  .read<PanicRejectedBloc>()
                                  .pagingController
                                  .refresh();
                            }
                          },
                        );
                      }),
                      BlocBuilder<PanicCompletedBloc, ComplaintListState>(
                          builder: (context, state) {
                        return _contentView(
                          context.read<PanicCompletedBloc>().pagingController,
                          PanicCustomerItemType.completed,
                          "txt_no_panic_completed".tr(),
                          (value) async {
                            final result =
                                await context.showScrollableBottomSheet<int>(
                              builder: (context, scrollController) {
                                return PanicCompletedBottomSheet(
                                    value, scrollController);
                              },
                            );
                            if (result != null) {
                              context
                                  .read<PanicCompletedBloc>()
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
    PanicCustomerItemType type,
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
            return PanicCustomerItem(
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
