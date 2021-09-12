import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/ui/complaint/bottomsheet/complaint_detail_bottomsheet.dart';
import 'package:amirta_mobile/ui/complaint/complaint_appbar.dart';
import 'package:amirta_mobile/ui/complaint/complaint_customer_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ComplaintScreen extends StatefulWidget {
  @override
  _ComplaintScreenState createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  final PagingController<int, String> pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    pagingController.appendLastPage(['a', 'b', 'd']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ComplaintAppBar(
        enableLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/complaint/history');
            },
            icon: ImageIcon(
              AssetImage(
                imageRes('ic_history_pengaduan.png'),
              ),
            ),
          ),
        ],
      ),
      body: PagedListView(
        padding: const EdgeInsets.all(spaceMedium),
        pagingController: pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: (context, item, position) {
            return ComplaintCustomerItem(
              onTap: () async {
                final result = await context.showScrollableBottomSheet<int>(
                  builder: (context, scrollController) {
                    return ComplaintDetailBottomSheet(scrollController);
                  },
                );
                if (result != null) {
                  setState(() {});
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
        ),
      ),
    );
  }
}
