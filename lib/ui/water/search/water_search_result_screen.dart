import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/res/resources.dart';
import 'package:amirta_mobile/ui/water/search/water_input_done_bottomsheet.dart';
import 'package:amirta_mobile/ui/water/water_appbar.dart';
import 'package:amirta_mobile/ui/water/water_customer_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class WaterSearchResultScreen extends StatefulWidget {
  @override
  _WaterSearchResultScreenState createState() =>
      _WaterSearchResultScreenState();
}

class _WaterSearchResultScreenState extends State<WaterSearchResultScreen> {
  final PagingController<int, String> pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    pagingController.appendLastPage(List.filled(10, 'Input'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WaterAppBar(),
      body: PagedListView(
        padding: const EdgeInsets.all(spaceMedium),
        pagingController: pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: (context, item, position) {
            return WaterCustomerItem(
              customerName: 'Asniar Ansar',
              locationName: 'Rusun Karang Anyar',
              inputDone: (position % 2) == 0,
              onTap: () {
                context.showScrollableBottomSheet(
                  builder: (context, scrollController) {
                    return WaterInputDoneBottomSheet(
                      scrollController: scrollController,
                    );
                  },
                );
              },
            );
          },
          noItemsFoundIndicatorBuilder: (context) {
            return Center(
              child: Text('txt_no_item_found'.tr()),
            );
          },
        ),
      ),
    );
  }
}
