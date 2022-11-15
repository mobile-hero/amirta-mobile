import 'package:amirta_mobile/bloc/complaint/list/complaint_list_bloc.dart';
import 'package:amirta_mobile/bloc/complaint/list/panic_types_bloc.dart';
import 'package:amirta_mobile/data/pengaduan/pengaduan_export.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/ui/common/common_panic_history_view.dart';
import 'package:amirta_mobile/ui/panic/bottomsheet/panic_completed_bottomsheet.dart';
import 'package:amirta_mobile/ui/panic/bottomsheet/panic_inprocess_bottomsheet.dart';
import 'package:amirta_mobile/ui/panic/bottomsheet/panic_rejected_bottomsheet.dart';
import 'package:amirta_mobile/ui/panic/panic_customer_item.dart';

class PanicHistoryScreen extends StatefulWidget {
  const PanicHistoryScreen({Key? key}) : super(key: key);

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
                        final bloc = context.read<PanicInProcessBloc>();
                        if (state is ComplaintListError) {
                          return ErrorContainer(
                            onTap: () {
                              bloc.add(LoadComplaint.inProcess);
                            },
                          );
                        }
                        return CommonPanicHistoryView(
                          pagingController: bloc.pagingController,
                          type: PanicCustomerItemType.neutral,
                          emptyMessage: "txt_no_panic_in_process".tr(),
                          onTap: (value) async {
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
                                bloc.pagingController.refresh();

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
                        final bloc = context.read<PanicRejectedBloc>();
                        if (state is ComplaintListError) {
                          return ErrorContainer(
                            onTap: () {
                              bloc.add(LoadComplaint.rejected);
                            },
                          );
                        }
                        return CommonPanicHistoryView(
                          pagingController: bloc.pagingController,
                          type: PanicCustomerItemType.rejected,
                          emptyMessage: "txt_no_panic_rejected".tr(),
                          onTap: (value) async {
                            final result =
                                await context.showScrollableBottomSheet<int>(
                              builder: (context, scrollController) {
                                return PanicRejectedBottomSheet(
                                    value, scrollController);
                              },
                            );
                            if (result != null) {
                              bloc.pagingController.refresh();
                            }
                          },
                        );
                      }),
                      BlocBuilder<PanicCompletedBloc, ComplaintListState>(
                          builder: (context, state) {
                        final bloc = context.read<PanicCompletedBloc>();
                        if (state is ComplaintListError) {
                          return ErrorContainer(
                            onTap: () {
                              bloc.add(LoadComplaint.completed);
                            },
                          );
                        }
                        return CommonPanicHistoryView(
                          pagingController: bloc.pagingController,
                          type: PanicCustomerItemType.completed,
                          emptyMessage: "txt_no_panic_completed".tr(),
                          onTap: (value) async {
                            final result =
                                await context.showScrollableBottomSheet<int>(
                              builder: (context, scrollController) {
                                return PanicCompletedBottomSheet(
                                    value, scrollController);
                              },
                            );
                            if (result != null) {
                              bloc.pagingController.refresh();
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
}
