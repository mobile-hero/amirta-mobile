import 'package:amirta_mobile/bloc/complaint/list/complaint_list_bloc.dart';
import 'package:amirta_mobile/bloc/complaint/list/complaint_types_bloc.dart';
import 'package:amirta_mobile/data/pengaduan/pengaduan_export.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/res/resources.dart';
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
          title: Text('History Pengaduan'),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              Container(
                color: egyptian,
                child: TabBar(
                  tabs: [
                    Tab(
                      text: 'Dalam Proses',
                    ),
                    Tab(
                      text: 'Penolakan',
                    ),
                    Tab(
                      text: 'Selesai',
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
                          final result =
                              await context.showScrollableBottomSheet<bool>(
                            builder: (context, scrollController) {
                              return ComplaintInProcessBottomSheet(
                                  value, scrollController);
                            },
                          );
                          if (result != null) {
                            Navigator.pushNamed(
                              context,
                              '/complaint/set-complete',
                            );
                          }
                        },
                      );
                    }),
                    BlocBuilder<ComplaintRejectedBloc, ComplaintListState>(
                        builder: (context, state) {
                      return _contentView(
                        context.read<ComplaintInProcessBloc>().pagingController,
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
                            setState(() {});
                          }
                        },
                      );
                    }),
                    BlocBuilder<ComplaintCompletedBloc, ComplaintListState>(
                        builder: (context, state) {
                      return _contentView(
                        context.read<ComplaintInProcessBloc>().pagingController,
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
                            setState(() {});
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
              onTap: onTap.call(item),
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
