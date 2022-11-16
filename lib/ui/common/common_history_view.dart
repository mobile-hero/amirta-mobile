import 'package:amirta_mobile/data/pengaduan/pengaduan.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

typedef HistoryItemBuilder = Widget Function(Pengaduan);

class CommonHistoryView extends StatelessWidget {
  final PagingController<int, Pengaduan> pagingController;
  final String emptyMessage;
  final HistoryItemBuilder itemBuilder;

  const CommonHistoryView({
    Key? key,
    required this.pagingController,
    required this.emptyMessage,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => pagingController.refresh(),
      color: context.isDark ? borderColor : null,
      child: PagedListView<int, Pengaduan>(
        padding: const EdgeInsets.all(spaceMedium),
        pagingController: pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: (context, item, position) {
            return itemBuilder(item);
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
          firstPageProgressIndicatorBuilder: (context) {
            return const MyProgressIndicator();
          }
        ),
      ),
    );
  }
}
