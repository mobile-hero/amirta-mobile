import 'package:amirta_mobile/bloc/complaint/list/complaint_list_bloc.dart';
import 'package:amirta_mobile/bloc/complaint/list/complaint_types_bloc.dart';
import 'package:amirta_mobile/data/pengaduan/pengaduan_export.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/ui/common/common_complaint_history_view.dart';
import 'package:amirta_mobile/ui/complaint/bottomsheet/complaint_completed_bottomsheet.dart';
import 'package:amirta_mobile/ui/complaint/bottomsheet/complaint_inprocess_bottomsheet.dart';
import 'package:amirta_mobile/ui/complaint/bottomsheet/complaint_rejected_bottomsheet.dart';
import 'package:amirta_mobile/ui/complaint/complaint_customer_item.dart';

class ComplaintHistoryScreen extends StatefulWidget {
  const ComplaintHistoryScreen({Key? key}) : super(key: key);

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
                        final bloc = context.read<ComplaintInProcessBloc>();
                        if (state is ComplaintListError) {
                          return ErrorContainer(
                            onTap: () {
                              bloc.add(LoadComplaint.inProcess);
                            },
                          );
                        }
                        return CommonComplaintHistoryView(
                          pagingController: bloc.pagingController,
                          type: ComplaintCustomerItemType.neutral,
                          emptyMessage: "txt_no_complaint_in_process".tr(),
                          onTap: (value) async {
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
                                bloc.pagingController.refresh();

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
                        final bloc = context.read<ComplaintRejectedBloc>();
                        if (state is ComplaintListError) {
                          return ErrorContainer(
                            onTap: () {
                              bloc.add(LoadComplaint.rejected);
                            },
                          );
                        }
                        return CommonComplaintHistoryView(
                          pagingController: bloc.pagingController,
                          type: ComplaintCustomerItemType.rejected,
                          emptyMessage: "txt_no_complaint_rejected".tr(),
                          onTap: (value) async {
                            final result =
                                await context.showScrollableBottomSheet<int>(
                              builder: (context, scrollController) {
                                return ComplaintRejectedBottomSheet(
                                    value, scrollController);
                              },
                            );
                            if (result != null) {
                              bloc.pagingController.refresh();
                            }
                          },
                        );
                      }),
                      BlocBuilder<ComplaintCompletedBloc, ComplaintListState>(
                          builder: (context, state) {
                        final bloc = context.read<ComplaintCompletedBloc>();
                        if (state is ComplaintListError) {
                          return ErrorContainer(
                            onTap: () {
                              bloc.add(LoadComplaint.completed);
                            },
                          );
                        }
                        return CommonComplaintHistoryView(
                          pagingController: bloc.pagingController,
                          type: ComplaintCustomerItemType.completed,
                          emptyMessage: "txt_no_complaint_completed".tr(),
                          onTap: (value) async {
                            final result =
                                await context.showScrollableBottomSheet<int>(
                              builder: (context, scrollController) {
                                return ComplaintCompletedBottomSheet(
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
