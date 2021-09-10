import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/res/resources.dart';
import 'package:amirta_mobile/ui/complaint/complaint_customer_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ComplaintHistoryScreen extends StatefulWidget {
  @override
  _ComplaintHistoryScreenState createState() => _ComplaintHistoryScreenState();
}

class _ComplaintHistoryScreenState extends State<ComplaintHistoryScreen> {
  int tabPosition = 0;

  final PagingController<int, String> inProcessController =
      PagingController(firstPageKey: 0);
  final PagingController<int, String> rejectedController =
      PagingController(firstPageKey: 0);
  final PagingController<int, String> completedController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    inProcessController.appendLastPage(['a', 'b', 'd']);
    rejectedController.appendLastPage(['a', 'b', 'd']);
    completedController.appendLastPage(['a', 'b', 'd']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  _contentView(
                    inProcessController,
                    ComplaintCustomerItemType.neutral,
                  ),
                  _contentView(
                    rejectedController,
                    ComplaintCustomerItemType.rejected,
                  ),
                  _contentView(
                    completedController,
                    ComplaintCustomerItemType.completed,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _contentView(
    PagingController pagingController,
    ComplaintCustomerItemType type,
  ) {
    return PagedListView(
      padding: const EdgeInsets.all(spaceMedium),
      pagingController: pagingController,
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (context, item, position) {
          return ComplaintCustomerItem(
            type: type,
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
      ),
    );
  }
}
