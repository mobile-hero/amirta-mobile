import 'package:amirta_mobile/data/pengaduan/pengaduan.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/ui/common/common_history_view.dart';
import 'package:amirta_mobile/ui/panic/panic_customer_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CommonPanicHistoryView extends StatelessWidget {
  final PagingController<int, Pengaduan> pagingController;
  final PanicCustomerItemType type;
  final String emptyMessage;
  final Function(Pengaduan) onTap;

  const CommonPanicHistoryView({
    Key? key,
    required this.pagingController,
    required this.type,
    required this.emptyMessage,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonHistoryView(
      pagingController: pagingController,
      emptyMessage: emptyMessage,
      itemBuilder: (item) {
        return PanicCustomerItem(
          item: item,
          type: type,
          onTap: () => onTap.call(item),
        );
      },
    );
  }
}
